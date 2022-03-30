from views.base.base_views import AuthBaseHandler
from models.album_model import Album, Photo
from service.utils import save_images
from service.paginate import paginate


class PhotoHandler(AuthBaseHandler):
    def get(self, album_id):
        """
        指定相册内的所有图片
        :return:
        """
        count, photos = paginate(self, Photo, Photo.album_id == album_id)
        photoJson = []
        for photo in photos:
            photo.name = self.static_url(photo.name, True)
            photoJson.append(photo.to_json())
        self.success({'count': count, 'results': photoJson})

    def post(self, album_id):
        """
        添加图片
        :return:
        """
        album = Album.query.filter(Album.id == album_id, not Album.deleted).first()
        assert album, '相册不存在: %r' % album_id

        image_metas = self.request.files.get('image', None)
        assert image_metas, '图片不能为空'

        image_names = [mate.get('filename') for mate in image_metas]
        image_url_list = save_images(image_metas)
        photos = [Photo(album_id=album.id, name=image_name) for image_name in image_names]
        Photo.saveAll(photos)
        self.success(image_url_list)

    def delete(self, album_id):
        """
        删除图片
        :return:
        """
        delete_ids = self.json_args.get('delete_ids', None)
        assert delete_ids, '参数不能为空'
        deleted_count = Photo.query.filter(Photo.id in delete_ids, Photo.album_id == album_id).delete()
        self.success(deleted_count)
