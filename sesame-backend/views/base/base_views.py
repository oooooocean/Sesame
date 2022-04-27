from tornado.web import RequestHandler
from models.user_model import User
from common.jwt_utils import JWTUtils
from common.exception import (
    ERROR_CODE_0,
    ERROR_CODE_1001,
    ERROR_CODE_1003,
    SaoException,
    ClientError
)
import jwt
from tornado.escape import json_decode
from conf.db import Session
from conf.logger import log_request_error


class BaseHandler(RequestHandler):

    def prepare(self):
        self.json_args = {}
        if self.request.method == "POST" and self.request.headers.get('Content-Type', '').startswith(
                'application/json'):
            self.json_args = json_decode(self.request.body)

    def http_response(self, error: SaoException, data=None):
        """
        响应
        :param error: 错误码
        :param data: 数据体
        :return:
        """
        self.set_status(error.get_http_status())
        self.set_header('Content-type', 'application/json')
        self.finish({'msg': error.msg, 'code': error.code, 'data': data})

    def success(self, data=None):
        self.http_response(ERROR_CODE_0, data)

    def simple_success(self):
        self.http_response(ERROR_CODE_0, True)

    def simple_fail(self):
        self.http_response(ERROR_CODE_0, False)

    def write_error(self, status_code: int, **kwargs) -> None:
        exc_info = kwargs.get('exc_info', None)

        if not exc_info:
            self.finish()
            return

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

    def on_finish(self) -> None:
        Session.remove()


class AuthBaseHandler(BaseHandler):

    def prepare(self):
        try:
            jwt_string = self.request.headers['Authorization']
            jwtPayload = JWTUtils.parse(jwt_string)
        except jwt.exceptions.ExpiredSignatureError:
            raise ERROR_CODE_1003
        else:
            self.current_user = Session.get(User, jwtPayload.uid)
            if not self.current_user: raise ClientError('用户不存在')
            if self.current_user.deleted: raise ERROR_CODE_1001
            super(AuthBaseHandler, self).prepare()
