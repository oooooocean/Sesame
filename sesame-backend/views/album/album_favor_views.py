from views.base.base_views import AuthBaseHandler
from models.album_model import Album, Photo
from service.paginate import paginate


class AlbumFavorHandler(AuthBaseHandler):

    def get(self):
        """
        @api {delete} /album/favor/ Get the favor album
        @apiVersion 0.0.1
        @apiGroup Album
        @apiDescription Get the favor album with assigned user

        @apiQuery {Number} [user_id] User's id
        @apiSuccess {Object[]} data photo list
        """
        user_id = self.get_argument('user_id', None) or self.current_user.id
        album_ids = [album.id for album in Album.query.filter(Album.user_id == user_id, ~Album.deleted).all()]
        count, photos = paginate(self, Photo, Photo.favor, Photo.album_id in album_ids, ~Photo.deleted)
        self.success({'count': count, 'results': [photo.to_json() for photo in photos]})
