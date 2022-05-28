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
        """
        @api {get} /config/ App configuration
        @apiVersion 0.0.1
        @apiName Configuration
        @apiGroup Common
        @apiDescription App configuration

        @apiSuccessExample {json} Success-Response:
            {
                "pageDefaultLimit": 10, # 默认每页数据
                "nickNameLimit": 20, # 昵称最大长度
                "albumDescriptionLimit": 100, # 相册描述最大长度
                "albumNameLimit": 10, # 相册名称最大长度
                "passwordMinLimit": 8, # 密码最小长度
                "postDescriptionLimit": 200, # 帖子描述最大长度
                "postPhotoLimit": 9 # 帖子最多照片数量
            }
        """
        return self.success({camel_case(key): value for key, value in COMMON_CONFIGS.items()})