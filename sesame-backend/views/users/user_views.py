from service.utils import save_images
from models.user_model import UserInfo, User
from views.base.base_views import AuthBaseHandler
from conf.db import sessions
from common.exception import (
    ERROR_CODE_0,
    ClientError
)
from service.validator import validate_user_nickname


class UserHandler(AuthBaseHandler):

    def prepare(self):
        uid = self.path_args[0]
        self.user = sessions.get(User, uid)
        if not self.user or self.user.deleted: raise ClientError('用户不存在, uid: %r' % uid)
        super(AuthBaseHandler, self).prepare()

    def get(self, _):
        """
        @api {get} /user/:user_id Get User Info
        @apiVersion 0.0.1
        @apiGroup User
        @apiDescription User's info

        @apiParam {String} user_id User's id

        @apiSuccessExample {json} response:
            {
                id: int,
                phone: string,
                info: {
                    nickname: string,
                    gender: int, // 1 male 2 female
                    avatar: string
                }
            }
        """

        json = self.user.to_json()
        json['info'] = self.user.info.to_json()
        return self.http_response(ERROR_CODE_0, json)

    def post(self, _):
        """
        @api {post} /user/:user_id Update User Info
        @apiVersion 0.0.1
        @apiGroup User
        @apiDescription Update User's info

        @apiParam {String} user_id User's id
        @apiBody {String} nickname User's nickname
        @apiBody {String} gender User's gender, 1 male 2 female
        @apiBody {File} image User's avatar

        @apiSuccess {Object} data User's info
        """

        user_info: UserInfo = self.user.info or UserInfo()

        nickname = self.get_body_argument('nickname', None)
        if nickname:
            is_valid, msg = validate_user_nickname(nickname)
            if not is_valid: raise ClientError(msg)
            if UserInfo.query.filter(UserInfo.nickname == nickname, UserInfo.id != self.user.id).first(): raise ClientError('来晚一步咯~, 昵称已被使用')
            user_info.nickname = nickname

        gender = self.get_body_argument('gender', None)
        if gender:
            if gender not in [1, 2]: raise ClientError('性别错误, 只能是1或2')
            user_info.gender = gender

        image_mates = self.request.files.get('image', None)
        if image_mates:
            user_info.avatar = save_images(image_mates)[0]

        self.user.info = user_info
        self.user.save()
        print(self.user.info.nickname)
        json = self.user.to_json()
        json['info'] = self.user.info.to_json()
        print(self.user.info.nickname)
        print(self.user.info.to_json())
        self.http_response(ERROR_CODE_0, json)
