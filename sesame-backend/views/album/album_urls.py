import views.album.album_views as album_views
import views.album.photo_views as photo_views
import views.album.album_favor_views as album_favor_views

urls = [
    (r'([0-9]+)?/?', album_views.AlbumHandler),
    (r'([0-9]+)/photo/?([0-9]+)?/?', photo_views.PhotoHandler),
    (r'favor/?', album_favor_views.AlbumFavorHandler)
]