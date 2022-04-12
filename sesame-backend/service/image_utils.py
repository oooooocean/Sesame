import os
from service.utils import save_files
from PIL import Image, ImageDraw, ImageFont
from conf.base import UPLOAD_PATH


def save_images(user_id, image_metas) -> [str]:
    """
    保存图片到本地
    :param user_id:
    :param image_metas: 图片元数据
    :return: 图片的完整link
    """
    if len(image_metas) == 0: return []

    cwd = os.getcwd()
    save_image_path = os.path.join(cwd, '%s%s/' % (UPLOAD_PATH, user_id))
    if not os.path.exists(save_image_path): os.mkdir(save_image_path)

    file_name_list = save_files(image_metas, save_image_path)
    return file_name_list


def get_thumbnail(image_path, width, height) -> Image.Image:
    with Image.open(image_path) as im:
        copy = im.copy()
        size = int(width if width else im.width), int(height if height else im.height)
        copy.thumbnail(size)
        return copy


def add_watermark(image: Image.Image, text='芝麻开门', margin=10) -> Image.Image:
    """
    图片添加水印
    图片转RGBA颜色格式 -> 创建遮罩 -> 绘制遮罩 -> 合并遮罩
    :param image:
    :param text:
    :param margin:
    :return:
    """
    copy = image.copy().convert('RGBA')
    # 创建上下文
    overlay = Image.new('RGBA', copy.size, (255, 255, 255, 0))
    overlay_draw = ImageDraw.Draw(overlay)

    # 绘制文字
    imageWidth, imageHeight = copy.size
    fontSize = int(imageWidth / 15)
    font = ImageFont.truetype("static/font/font.ttf", fontSize)
    textWidth, textHeight = overlay_draw.textsize(text, font)
    x = imageWidth - textWidth - margin
    y = imageHeight - textHeight - margin
    overlay_draw.text((x, y), text, font=font, fill=(255, 255, 255, 50))

    return Image.alpha_composite(copy, overlay)
