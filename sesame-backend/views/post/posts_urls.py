from views.post.posts_views import PostsHandler

urls = [
    (r'([0-9]+)?/?', PostsHandler)
]