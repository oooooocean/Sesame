import tornado.web as web
import os.path as path
from common.url_router import url_wrapper, include
from conf.logger import log_request
from conf.base import IS_PRODUCT


class Application(web.Application):
    def __init__(self):
        handlers = url_wrapper([
            (r'/v1/login/', include('views.login.login_urls')),
            (r'/v1/user/', include('views.users.user_urls')),
            (r'/v1/album/', include('views.album.album_urls')),
            (r'/v1/common/', include('views.common.common_urls')),
            (r'/v1/pic/', include('views.pic.pic_urls')),
            (r'/v1/post/', include('views.post.post_urls')),
            (r'/v1/posts/', include('views.post.posts_urls'))
        ])
        settings = dict(
            debug=not IS_PRODUCT,
            static_path=path.join(path.dirname(__file__), 'static'),
            template_path=path.join(path.dirname(__file__), 'templates'),
            log_function=log_request,
        )
        super().__init__(handlers, **settings)
