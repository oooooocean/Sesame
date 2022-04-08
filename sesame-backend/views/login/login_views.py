from models.user_model import User
from views.base.base_views import BaseHandler
import common.jwt_utils
from service.utils import check_code
from loguru import logger
from common.exception import ClientError
from service.password import validate_password
from service.validator import validate_phone, validate_password as validate_password_format
from common.exception import ClientError


class LoginHandler(BaseHandler):
    def post(self):
        """
        @api {post} /login Login in
        @apiVersion 0.0.1
        @apiName Login
        @apiGroup Login
        @apiDescription Login in with password or sms code

        @apiBody {String} phone User's phone
        @apiBody {String} [password] User's password
        @apiBody {String} [code] SMS verification code

        @apiSuccessExample {json} response:
            {
                user: user_json,
                token: token
            }
        """
        phone = self.json_args.get('phone', None)
        password = self.json_args.get('password', None)
        code = self.json_args.get('code', None)

        if not validate_phone(phone): raise ClientError('手机号不正确')

        if password:
            self._login_with_password(phone, password)  # 密码登录
        elif code:
            self._login_with_code(phone, code)
        else:
            raise ClientError('参数不可为空')

    def _login_with_password(self, phone, password):
        """
        密码登录
        :param phone:
        :param password:
        :return:
        """
        is_valid, msg = validate_password_format(password)
        if not is_valid: raise ClientError(msg)
        user = User.query.filter_by(phone=phone).first()
        if not user: raise ClientError('用户不存在')
        if not user.password: raise ClientError('用户密码不存在, 请先设置密码')
        if not validate_password(user.password, password): raise ClientError('密码错误')
        self._login_success(user)

    def _login_with_code(self, phone, code):
        """
        验证码登录, 如果用户不存在, 则自动注册
        :param phone:
        :param code:
        :return:
        """
        if not check_code(code): raise ClientError('验证码错误')
        user = User.query.filter_by(phone=phone).first() or self._add_new_user(phone)
        self._login_success(user)

    def _login_success(self, user):
        """
        登录成功
        :param user:
        :return: 用户信息和token
        """
        user_json = user.to_json()
        user_json['info'] = user.info.to_json() if user.info else None
        token = common.jwt_utils.JWTUtils.create(user.id)
        self.success({'user': user_json, 'token': token})

    def _add_new_user(self, phone):
        """
        添加新用户
        :param phone:
        :return:
        """
        logger.info('LoginHandle/post: 插入新用户 %r' % (phone,))
        ex_user = User(phone=phone)
        ex_user.save()
        return ex_user
