from views.base.base_views import BaseHandler
from service.utils import save_images
from common.exception import (
    ERROR_CODE_0,
    ERROR_CODE_1001
)


class UploadHandler(BaseHandler):
    def post(self):
        try:
            image_metas = self.request.files['image']
        except Exception:
            raise ERROR_CODE_1001
        else:
            image_url_list = save_images(image_metas)
            self.http_response(ERROR_CODE_0, image_url_list)
