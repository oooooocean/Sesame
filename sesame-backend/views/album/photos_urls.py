import views.album.photos_views as photos_views

urls = [
    (r'([0-9]+)?/?', photos_views.PhotosHandler)
]