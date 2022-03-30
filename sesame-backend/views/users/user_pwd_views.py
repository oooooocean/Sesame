from views.base.base_views import AuthBaseHandler
from service.password import encrypt_password, validate_password
from service.validator import validate_password as vp


class UserPasswordHandler(AuthBaseHandler):

    def post(self):
        """
        设置用户密码
        :return:
        """
        password = self.json_args.get('password', None)
        assert not self.current_user.password, '已有密码'

        self._save_password(password)
        self.success()

    def put(self):
        """
        修改用户密码
        :return:
        """
        old_password = self.json_args.get('old_password', None)
        new_password = self.json_args.get('new_password', None)
        assert old_password and new_password, '参数不完整'
        assert old_password != new_password, '密码不能一致'
        assert validate_password(old_password, self.current_user.password), '用户密码错误'
        self._save_password(new_password)
        self.success()

    def _save_password(self, password):
        is_valid, msg = vp(password)  # 验证新密码格式
        assert is_valid, msg

        self.current_user.password = encrypt_password(password)
        self.current_user.save()
