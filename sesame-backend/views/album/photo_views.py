from views.base.base_views import AuthBaseHandler
from models.album_model import Album, Photo
from service.utils import save_images
from service.paginate import paginate
from common.exception import ClientError, ServerError, ERROR_CODE_1001


class PhotoHandler(AuthBaseHandler):
    def get(self, album_id, photo_id):
        """
        @api {get} /album/:album_id Get photos of album
        @apiVersion 0.0.1
        @apiGroup Photo
        @apiDescription Get photos of album

        @apiParam {Number} album_id Album's id
        @apiQuery {Number} [user_id] User's id

        @apiSuccessExample {json} response:
            {
                count: int,
                results: [
                    {
                        id: int,
                        name: string,
                        description: string?,
                        favor: bool
                    }
                    ...
                ]
            }
            or
            signal photo info.
        """
        user_id = self.get_argument('user_id', None) or self.current_user.id
        album = Album.query.filter(Album.id == album_id, Album.user_id == user_id).first()
        if not album: raise ClientError('对应相册不存在')
        if photo_id:
            photo = Photo.query.filter(Photo.id == photo_id, Photo.album_id == album_id, ~Photo.deleted).first()
            if not photo: raise ClientError('图片不存在')
            self.success(photo.to_json())
        else:
            count, photos = paginate(self, Photo, Photo.album_id == album_id)
            self.success({'count': count, 'results': [photo.to_json() for photo in photos]})

    def post(self, album_id, photo_id):
        """
        添加图片
        :return:
        """
        album = Album.query.filter(Album.id == album_id, not Album.deleted).first()
        if not album: raise ClientError('相册不存在: %r' % album_id)

        if not photo_id:
            self._edit_image(photo_id)
        else:
            self._add_images(album_id)

    def delete(self, album_id):
        """
        删除图片
        :return:
        """
        delete_ids = self.json_args.get('delete_ids', None)
        assert delete_ids, '参数不能为空'
        deleted_count = Photo.query.filter(Photo.id in delete_ids, Photo.album_id == album_id).delete()
        if deleted_count == 0:
            raise ServerError('删除失败')
        self.simpleSuccess()

    def _edit_image(self, photo_id):
        """
        编辑图片: 添加favor或添加描述
        :param photo_id:
        :return:
        """
        photo = Photo.query.filter(Photo.id == photo_id, not Photo.deleted).first()
        if not photo: raise ClientError('图片不存在')
        description = self.json_args.get('description', None)
        favor = self.json_args.get('favor', None)
        if not description and not favor: raise ERROR_CODE_1001
        if description:
            photo.description = description
        if favor:
            photo.favor = favor
        photo.save()
        self.simpleSuccess()

    def _add_images(self, album_id):
        """
        添加图片到相册
        :param album_id:
        :return:
        """
        image_metas = self.request.files.get('image', None)
        if not image_metas: raise ClientError('图片不能为空')

        image_names = [mate.get('filename') for mate in image_metas]
        save_images(image_metas)
        photos = [Photo(album_id=album_id, name=image_name) for image_name in image_names]
        Photo.saveAll(photos)
        self.simpleSuccess()
