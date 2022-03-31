from views.base.base_views import AuthBaseHandler
from common.exception import ClientError, ERROR_CODE_0, ERROR_CODE_1005, ERROR_CODE_1006
from models.album_model import Album, Photo
from service.validator import validate_album_name, validate_album_description


class AlbumHandler(AuthBaseHandler):

    def get(self, album_id):
        """
        用户的所有相册或指定相册
        :return:
        """
        if album_id:
            album = Album.query.filter(Album.id == album_id, not Album.deleted).first()
            if not album: raise ClientError('album 不存在: %r' % album_id)
            self.http_response(ERROR_CODE_0, self._to_json(album))
        else:
            albums = Album.query.filter(Album.user_id == self.current_user.id, not Album.deleted).all()
            albums_json = [self._to_json(album) for album in albums]
            self.http_response(ERROR_CODE_0, albums_json)

    def post(self, album_id):
        """
        新增/修改相册
        :return:
        """
        name = self.json_args.get('name', None)
        description = self.json_args.get('description', None)

        isValid, msg = validate_album_name(name)
        if not isValid: raise ClientError(msg)
        isValid, msg = validate_album_description(description)
        if not isValid: raise ClientError(msg)

        if album_id:
            self._update(name, description, album_id)
        else:
            self._add(name, description)

    def delete(self, album_id):
        """
        删除
        :return:
        """
        if not album_id: raise ClientError('参数缺失: album_id')
        album = Album.query.filter(Album.id == album_id).first()
        album.deleted = True
        album.save()
        self.http_response(ERROR_CODE_0)

    def _add(self, name, description):
        """
        新增
        :param name:
        :return:
        """
        album = Album.query.filter(Album.user_id == self.current_user.id,
                                   Album.name == name,
                                   not Album.deleted).first()
        if album: raise ClientError('相册已存在: %r' % name)
        album = Album(name=name, description=description, user_id=self.current_user.id)
        album.save()
        self.http_response(ERROR_CODE_0, album.id)

    def _update(self, name, description, album_id):
        """
        修改
        :param name:
        :param album_id:
        :return:
        """
        album = Album.query.filter(Album.id == album_id, not Album.deleted).first()
        if not album: raise ClientError('相册不存在: %r' % name)
        album.name = name
        album.description = description
        album.save()
        self.http_response(ERROR_CODE_0, album.id)

    def _to_json(self, album):
        if not album.cover:
            photo = Photo.query.filter(Photo.album_id == album.id, not Photo.deleted).first()
            album.cover = photo
        return album.to_json()
