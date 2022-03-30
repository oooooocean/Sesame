import os
from hashlib import sha256
from hmac import HMAC


def encrypt_password(password: str, salt=None):
    """
    构建密文密码
    随机生成 64 bits 的 salt, 再选择 SHA-256 算法使用 HMAC 对密码和 salt 进行 5 次叠代混淆, 最后将 salt 和 hash 结果一起返回.
    :param salt:
    :param password:
    :return:
    """
    salt = salt if salt else os.urandom(8)

    result = password
    for i in range(5):
        result = HMAC(password.encode('utf8'), salt, sha256).digest()
    return salt + result


def validate_password(hashed: bytes, password: str):
    return hashed == encrypt_password(password, hashed[:8])
