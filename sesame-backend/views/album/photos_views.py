from views.base.base_views import AuthBaseHandler
from models.album_model import Photo, Album
from service.paginate import paginate_json


class PhotosHandler(AuthBaseHandler):

    def get(self, user_id):
        user_id = user_id or self.current_user.id
        albums = [album.id for album in Album.query.filter(Album.user_id == user_id, ~Album.deleted).all()]
        count, photos = paginate_json(self, Photo, Photo.album_id.in_(albums), ~Photo.deleted, order_by=Photo.id.desc())
        self.success({'count': count, 'results': [photo.to_json() for photo in photos]})
