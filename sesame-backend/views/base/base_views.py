from tornado.web import RequestHandler
from models.user_model import User
import json
from common.jwt_utils import JWTUtils
from common.exception import (
    ERROR_CODE_0,
    ERROR_CODE_1003,
    SaoException
)
import jwt
from tornado.escape import json_decode
from conf.db import sessions
from conf.logger import log_request_error


class BaseHandler(RequestHandler):

    def prepare(self):
        if self.request.method == "POST":
            assert self.request.headers.get('Content-Type', '').startswith('application/json'), \
                'Content-Type 设置错误'
            self.json_args = json_decode(self.request.body)

    def http_response(self, error: SaoException, data=None):
        """
        响应
        :param error: 错误码
        :param data: 数据体
        :return:
        """
        self.set_status(error.getHttpStatus())
        self.finish(json.dumps({'msg': error.msg, 'code': error.code, 'data': data}))

    def success(self, data=None):
        self.finish(json.dumps({'msg': ERROR_CODE_0.msg, 'code': ERROR_CODE_0.code, 'data': data}))

    def write_error(self, status_code: int, **kwargs) -> None:
        exc_info = kwargs.get('exc_info', None)

        if issubclass(exc_info[0], Exception):
            self.log_error()

        if exc_info[0] is SaoException:
            self.http_response(exc_info[1])
        elif exc_info[0] is AssertionError:
            self.http_response(SaoException(msg=exc_info[1].__str__(), code=1007))
        else:
            super().write_error(status_code, **kwargs)

    def log_error(self):
        uid = self.current_user.id if self.current_user else ''
        log_request_error(uid, self.request)


class AuthBaseHandler(BaseHandler):

    def prepare(self):
        try:
            jwt_string = self.request.headers['Authorization']
            jwtPayload = JWTUtils.parse(jwt_string)
        except jwt.exceptions.ExpiredSignatureError:
            raise ERROR_CODE_1003
        else:
            self.current_user = sessions.get(User, jwtPayload.uid)
            assert self.current_user, '用户不存在'
            super(AuthBaseHandler, self).prepare()
