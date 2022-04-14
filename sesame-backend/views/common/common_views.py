from views.base.base_views import BaseHandler
from service.image_utils import save_images
from common.exception import (
    ERROR_CODE_0,
    ClientError
)
from models.feedback import FeedbackCategory
from service.utils import camel_case
from conf.base import COMMON_CONFIGS


class UploadHandler(BaseHandler):
    def post(self):
        try:
            image_metas = self.request.files['files']
        except Exception:
            raise ClientError('图片为空')
        else:
            image_url_list = save_images(image_metas)
            self.http_response(ERROR_CODE_0, image_url_list)


class FeedbackHandler(BaseHandler):
    def get(self):
        self.render('feedback.html', categorys=FeedbackCategory)


class AppConfigHandler(BaseHandler):
    def get(self):
        return self.success({camel_case(key): value for key, value in COMMON_CONFIGS.items()})