from views.post.post_views import PostHandler
from views.post.post_favor_views import PostFavorHandler

urls = [
    (r'([0-9]+)?/?', PostHandler),
    (r'favor/([0-9]+)/?', PostFavorHandler),
]