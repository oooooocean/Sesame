from views.base.base_views import AuthBaseHandler
from models.post_model import Post
from models.post_favor_model import PostFavor
from common.exception import ClientError
from service.paginate import paginate_json


class PostFavorHandler(AuthBaseHandler):

    def get(self, post_id):
        """
        @api {get} /post/:post_id/favor fetch all like of particular post
        @apiVersion 0.0.1
        @apiName All favors
        @apiGroup Post
        @apiDescription fetch all like of particular post

        @apiParam {Number} post_id Post's id

        @apiSuccess {Object[]} data all favors.
        """
        self.success(paginate_json(self, PostFavor, PostFavor.post_id == post_id, order_by=PostFavor.id.desc()))

    def post(self, post_id):
        """
        @api {post} /post/:post_id/favor like a post
        @apiVersion 0.0.1
        @apiName Like a post
        @apiGroup Post
        @apiDescription like a post

        @apiParam {Number} post_id Post's id

        @apiSuccess {Boolean} data true
        """
        user_id = self.json_args.get('user_id', None) or self.current_user.id
        post = Post.query.filter(Post.id == post_id, ~Post.deleted).first()
        if not post:
            raise ClientError('帖子不存在')

        if PostFavor.query.filter(PostFavor.post_id == post_id, PostFavor.favor_user_id == user_id).first():
            raise ClientError('请不要重复点赞')

        favor = PostFavor(post_id=post_id, favor_user_id=user_id)
        favor.save()
        self.simple_success()

    def delete(self, post_id):
        """
        @api {delete} /post/favor/:post_id cancel the favor
        @apiVersion 0.0.1
        @apiName cancel the favor
        @apiGroup Post
        @apiDescription cancel the favor

        @apiParam {Number} post_id Post's id

        @apiSuccess {Boolean} data true
        """
        user_id = self.json_args.get('user_id', None) or self.current_user.id
        post = Post.query.filter(Post.id == post_id, ~Post.deleted).first()
        if not post: raise ClientError('帖子不存在')

        PostFavor.delete(PostFavor.post_id == post_id, PostFavor.favor_user_id == user_id)
        self.simple_success()
