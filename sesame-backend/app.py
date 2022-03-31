import tornado.web as web
import os.path as path
from common.url_router import url_wrapper, include
from conf.logger import log_request


class Application(web.Application):
    def __init__(self):
        handlers = url_wrapper([
            (r'/v1/login/', include('views.login.login_urls')),
            (r'/v1/user/', include('views.users.user_urls')),
            (r'/v1/album/', include('views.album.album_urls')),
            (r'/v1/common/', include('views.common.common_urls')),
            (r'/v1/pic/', include('views.pic.pic_urls')),
        ])
        settings = dict(
            debug=True,
            static_path=path.join(path.dirname(__file__), 'static'),
            template_path=path.join(path.dirname(__file__), 'templates'),
            log_function=log_request,
        )
        super().__init__(handlers, **settings)
