from views.base.base_views import BaseHandler
import os.path as path
from PIL import Image
from io import BytesIO
from tornado.web import HTTPError


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
        components = image_name.split('.')
        if len(components) != 2: raise HTTPError(status_code=500)

        width = self.get_argument('width', None)
        height = self.get_argument('height', None)
        image_name = 'upload/%s' % image_name
        image_path = path.join(self.application.settings['static_path'], image_name)

        if not width and not height:
            with open(image_path, 'rb') as f:
                self.finish(f.read())
            return
        self._get_thumbnail(image_path, width, height, components[1])

    def _get_thumbnail(self, image_path, width, height, ext):
        with Image.open(image_path) as im:
            copy = im.copy()
            size = int(width if width else im.width), int(height if height else im.height)
            copy.thumbnail(size)
            temp_io = BytesIO()
            copy.save(temp_io, format=ext)
            self.finish(temp_io.getvalue())
