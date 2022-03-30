import views.album.album_views as album_views
import views.album.photo_views as photo_views

urls = [
    (r'([0-9]?/?)', album_views.AlbumHandler),
    (r'([0-9]+)/photo/?', photo_views.PhotoHandler)
]