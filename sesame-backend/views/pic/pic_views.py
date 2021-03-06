from views.base.base_views import BaseHandler
import os.path as path
from PIL import Image, ImageDraw, ImageFont
from io import BytesIO
from service.image_utils import get_thumbnail, add_watermark
from conf.base import SERVER_CONFIGS


class PicHandler(BaseHandler):
    def prepare(self):
        self.set_header('Content-Type', 'image/jpg')

    def get(self, image_name):
        """
        @api {get} /pic/:pic_name Pic Tool
        @apiVersion 0.0.1
        @apiName Pic Tool
        @apiGroup Other
        @apiDescription Clip image with special size, if not width and height, will return origin data.

        @apiParam {String} pic_name Image name
        @apiQuery {Number} width clip width
        @apiQuery {Number} height clip height

        @apiSuccess {Object} data Image data
        """

        width = self.get_argument('width', None)
        height = self.get_argument('height', None)
        user_id = self.get_argument('user_id', None)
        image_path = SERVER_CONFIGS['upload_path'] + ('%s/%s' % (user_id, image_name) if user_id else '%s' % (image_name,))

        if not path.exists(image_path):
            self.send_error(400)
            return

        if not width and not height:
            with Image.open(image_path) as im:
                image = im.copy()
        else:
            image = get_thumbnail(image_path, width, height)

        copy = add_watermark(image)
        temp_io = BytesIO()
        copy.save(temp_io, format='jpeg')
        self.finish(temp_io.getvalue())
