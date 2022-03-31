from views.base.base_views import AuthBaseHandler
from models.album_model import Photo
from service.paginate import paginate


class AlbumFavorHandler(AuthBaseHandler):

    def get(self):
        """
        获取精选相册
        """
        count, photos = paginate(self, Photo, Photo.favor, not Photo.deleted)
        photoJson = []
        for photo in photos:
            photo.name = self.static_url(photo.name, True)
            photoJson.append(photo.to_json())
        self.success({'count': count, 'results': photoJson})
