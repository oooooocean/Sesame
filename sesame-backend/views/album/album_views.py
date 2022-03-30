from views.base.base_views import AuthBaseHandler
from common.exception import ERROR_CODE_1001, ERROR_CODE_0, ERROR_CODE_1005, ERROR_CODE_1006
from models.album_model import Album
from service.validator import validate_album_name


class AlbumHandler(AuthBaseHandler):

    def get(self, album_id):
        """
        用户的所有相册或指定相册
        :return:
        """
        if album_id:
            album = Album.query.filter(Album.id == album_id, not Album.deleted).first()
            assert album, 'album 不存在: %r' % album_id
            self.http_response(ERROR_CODE_0, album.to_json())
        else:
            albums = Album.query.filter(Album.user_id == self.current_user.id, not Album.deleted).all()
            albums_json = [album.to_json() for album in albums]
            self.http_response(ERROR_CODE_0, albums_json)

    def post(self, album_id):
        """
        新增/修改相册
        :return:
        """
        name = self.json_args.get('name', None)

        isValid, msg = validate_album_name(name)
        assert isValid, msg

        if album_id:
            self._update(name, album_id)
        else:
            self._add(name)

    def _add(self, name):
        """
        新增
        :param name:
        :return:
        """
        album = Album.query.filter(Album.user_id == self.current_user.id,
                                   Album.name == name,
                                   not Album.deleted).first()
        assert not album, '相册已存在: %r' % name
        album = Album(name=name, user_id=self.current_user.id)
        album.save()
        self.http_response(ERROR_CODE_0, album.id)

    def _update(self, name, album_id):
        """
        修改
        :param name:
        :param album_id:
        :return:
        """
        album = Album.query.filter(Album.id == album_id, not Album.deleted).first()
        assert album, '相册不存在: %r' % name
        album.name = name
        album.save()
        self.http_response(ERROR_CODE_0, album.id)

    def delete(self, album_id):
        """
        删除
        :return:
        """
        assert album_id, '参数缺失: album_id'
        album = Album.query.filter(Album.id == album_id).first()
        album.deleted = True
        album.save()
        self.http_response(ERROR_CODE_0)
