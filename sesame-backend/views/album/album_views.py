from views.base.base_views import AuthBaseHandler
from common.exception import ClientError, ERROR_CODE_0
from models.album_model import Album, Photo
from service.validator import validate_album_name, validate_album_description


class AlbumHandler(AuthBaseHandler):

    def get(self, album_id):
        """
        @api {get} /album/:album_id Get user's albums
        @apiVersion 0.0.1
        @apiGroup Album
        @apiDescription Get user's albums

        @apiParam {Number} [album_id] Album's id
        @apiQuery {Number} [user_id] User's id

        @apiSuccessExample {json} response:
            [
                {
                    id: int,
                    name: string,
                    description: string?,
                    cover: string?
                }
                ...
            ]
        """
        user_id = self.get_argument('user_id', None) or self.current_user.id

        if album_id:
            album = Album.query.filter(Album.id == album_id, not Album.deleted).first()
            if not album: raise ClientError('album 不存在: %r' % album_id)
            self.http_response(ERROR_CODE_0, self._to_json(album))
        else:
            albums = Album.query.filter(Album.user_id == user_id, ~Album.deleted).all()
            albums_json = [self._to_json(album) for album in albums]
            self.http_response(ERROR_CODE_0, albums_json)

    def post(self, album_id):
        """
        @api {post} /album/:album_id Update or Add user's albums
        @apiVersion 0.0.1
        @apiGroup Album
        @apiDescription Update or Add user's albums

        @apiParam {Number} [album_id] Album's id
        @apiBody {Number} [user_id] User's id
        @apiBody {String} name Album's name
        @apiBody {String} description Album's description

        @apiSuccess {Object} data Album info
        """
        user_id = self.get_argument('user_id', None) or self.json_args.get('user_id', None) or self.current_user.id
        name = self.get_argument('name', None) or self.json_args.get('name', None)
        description = self.get_argument('description', None) or self.json_args.get('description', None)

        is_valid, msg = validate_album_name(name)
        if not is_valid: raise ClientError(msg)
        is_valid, msg = validate_album_description(description)
        if not is_valid: raise ClientError(msg)

        if album_id:
            self._update(user_id, album_id, name, description)
        else:
            self._add(user_id, name, description)

    def delete(self, album_id):
        """
        @api {delete} /album/:album_id Delete user's albums
        @apiVersion 0.0.1
        @apiGroup Album
        @apiDescription Delete user's albums

        @apiParam {Number} album_id Album's id
        @apiQuery {Number} [user_id] User's id

        @apiSuccess {Boolean} data success or fail
        """
        if not album_id: raise ClientError('参数缺失: album_id')
        user_id = self.get_argument('user_id') or self.current_user.id
        album = Album.query.filter(Album.id == album_id, Album.user_id == user_id).first()
        album.deleted = True
        album.save()
        self.success(True)

    def _add(self, user_id, name, description):
        """
        新增
        :param name:
        :return:
        """
        album = Album.query.filter(Album.user_id == user_id,
                                   Album.name == name,
                                   ~Album.deleted).first()
        print(user_id, name)
        print(album)
        if album: raise ClientError('相册已存在: %r' % name)
        album = Album(name=name, description=description, user_id=user_id)
        album.save()
        self.success(self._to_json(album))

    def _update(self, user_id, album_id, name, description):
        """
        修改
        :param name:
        :param album_id:
        :return:
        """
        if not album_id: raise ClientError('参数缺失: album_id')
        album = Album.query.filter(Album.id == album_id, ~Album.deleted, Album.user_id==user_id).first()
        if not album: raise ClientError('相册不存在: %r' % name)
        album.name = name
        album.description = description
        album.save()
        self.http_response(ERROR_CODE_0, self._to_json(album))

    def _to_json(self, album):
        if not album.cover:
            photo = Photo.query.filter(Photo.album_id == album.id, not Photo.deleted).first()
            album.cover = photo
        return album.to_json()
