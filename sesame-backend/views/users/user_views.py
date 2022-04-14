from service.image_utils import save_images
from models.user_model import UserInfo, User
from models.gender import Gender
from views.base.base_views import AuthBaseHandler
from conf.db import Session
from common.exception import (
    ERROR_CODE_0,
    ClientError
)
from service.validator import validate_user_nickname


class UserHandler(AuthBaseHandler):

    def prepare(self):
        uid = self.path_args[0]
        self.user = Session.get(User, uid)
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
        return self.success(self.user.to_json())

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

        nickname = self.get_argument('nickname', None)
        if nickname:
            is_valid, msg = validate_user_nickname(nickname)
            if not is_valid: raise ClientError(msg)
            if UserInfo.query.filter(UserInfo.nickname == nickname, UserInfo.id != self.user.id).first(): raise ClientError('来晚一步咯~, 昵称已被使用')
            user_info.nickname = nickname

        gender = self.get_argument('gender', None)
        if gender:
            try:
                user_info.gender = Gender(int(gender))
            except ValueError:
                raise ClientError('性别错误, 只能是1或2')

        image_mates = self.request.files.get('images', None)
        if image_mates:
            user_info.avatar = save_images(self.user.id, image_mates)[0]

        self.user.info = user_info
        self.user.save()
        self.success(self.user.to_json())
