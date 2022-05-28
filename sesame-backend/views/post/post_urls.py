from views.post.post_views import PostHandler
from views.post.post_favor_views import PostFavorHandler
from views.post.post_comment_views import PostCommentHandler

urls = [
    (r'([0-9]+)?/?', PostHandler),
    (r'([0-9]+)/favor/?', PostFavorHandler),
    (r'([0-9]+)/comment/?', PostCommentHandler),
]