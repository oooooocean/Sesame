import http.client as ht


class SaoException(Exception):
    codeMapper = {
        0: ht.OK,  # 200
        1000: ht.UNAUTHORIZED,  # 401
        1008: ht.INTERNAL_SERVER_ERROR,
        1001: ht.UNAUTHORIZED,
    }

    def __init__(self, msg, code, detail=None):
        self.code = code
        self.msg = msg
        self.detail = detail

    def getHttpStatus(self):
        return self.codeMapper.get(self.code, None) or ht.BAD_REQUEST


ERROR_CODE_0 = SaoException('ok', 0)
ERROR_CODE_1000 = SaoException('Authorization 缺失', 1000)
ERROR_CODE_1001 = SaoException('账户失效', 1001)
ERROR_CODE_1003 = SaoException('登录过期', 1003)
ERROR_CODE_1007 = SaoException('客户端入参错误', 1007)
ERROR_CODE_1008 = SaoException('服务端错误', 1008)


def ClientError(msg: str) -> SaoException:
    return SaoException(msg, 1007)


def ServerError(msg: str) -> SaoException:
    return SaoException(msg, 1008)
