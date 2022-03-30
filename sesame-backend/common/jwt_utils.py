import jwt
import time
from collections import namedtuple

JWTPayload = namedtuple('JWTPayload', 'uid exp')


class JWTUtils:
    SECRET = 'SAO-Sao_sao'
    EXP = 24 * 60 * 60

    @classmethod
    def create(cls, user_id):
        payload = {'uid': user_id, 'exp': int(time.time()) + JWTUtils.EXP}
        encoded = jwt.encode(payload, JWTUtils.SECRET, algorithm='HS256')
        return encoded

    @classmethod
    def parse(cls, jwt_string):
        payload = jwt.decode(jwt_string, JWTUtils.SECRET, algorithms='HS256')
        return JWTPayload(payload['uid'], payload['exp'])
