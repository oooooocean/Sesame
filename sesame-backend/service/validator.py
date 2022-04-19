import re
from conf.base import COMMON_CONFIGS


def validate_phone(phone: str):
    if not phone:
        return False
    pattern = r'^1(3[0-9]|4[5,7]|5[0,1,2,3,5,6,7,8,9]|6[2,5,6,7]|7[0,1,7,8]|8[0-9]|9[1,8,9])\d{8}$'
    return re.match(pattern, phone)


def validate_password(password: str) -> tuple:
    """
    检查密码格式
    1. 长度至少8位
    2. 字母, 数字, 下划线混合, 不能包含特殊字符
    :param password:
    :return:
    """
    if not password:
        return False, '密码不能为空'
    if len(password) < COMMON_CONFIGS['password_min_limit']:
        return False, '密码长度至少8位'
    if not re.search(r'[\d]+', password):
        return False, '密码错误: 必须包含数字'
    if not re.search(r'[a-zA-z]+', password):
        return False, '密码错误: 必须包含英文字母'
    if not re.search(r'^[a-zA-Z0-9_]+$', password):
        return False, '密码错误: 仅能使用英文字母, 数字和下划线'
    return True, None


def validate_str(crude: str, label: str, max_len: int, min_len: int = 1, nullable=False) -> tuple:
    """
    字母 数字 下划线 中文
    :param crude:
    :param label:
    :param max_len:
    :param min_len:
    :param nullable:
    :return:
    """
    if not crude:
        return False, '%r不能为空' % label if not nullable else True, None

    pattern = '[\\w\\u4e00-\\u9fa5]{%d,%d}' % (min_len, max_len)
    if not re.match(pattern, crude):
        return False, '%r不能包含特殊字符, 且不超过%d个字符' % (label, max_len)
    return True, None


def validate_album_name(name: str) -> tuple:
    """
    验证相册名称
    :param name:
    :return:
    """
    return validate_str(name, '相册', COMMON_CONFIGS['album_name_limit'])


def validate_album_description(description: str) -> tuple:
    """
    验证相册描述
    :param description:
    :return:
    """
    return validate_str(description, '相册描述', COMMON_CONFIGS['album_description_limit'], nullable=True)


def validate_user_nickname(name: str) -> tuple:
    """
    用户昵称
    :param name:
    :return:
    """
    return validate_str(name, '昵称', COMMON_CONFIGS['nick_name_limit'])


def validate_post_description(description: str) -> tuple:
    """
    帖子描述
    :param description:
    :return:
    """
    return validate_str(description, '内容', COMMON_CONFIGS['post_description_limit'])