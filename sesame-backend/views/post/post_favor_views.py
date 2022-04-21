from views.base.base_views import AuthBaseHandler
from models.post_model import Post
from models.post_favor_model import PostFavor
from common.exception import ClientError


class PostFavorHandler(AuthBaseHandler):

    def get(self, post_id):
        """
        @api {get} /post/favor/:post_id fetch all like of particular post
        @apiVersion 0.0.1
        @apiName All favors
        @apiGroup Post
        @apiDescription fetch all like of particular post

        @apiParam {Number} post_id Post's id

        @apiSuccess {Object[]} data all favors.
        """
        favors = [favor.to_json() for favor in PostFavor.query.filter(PostFavor.post_id == post_id).all()]
        self.success(favors)

    def post(self, post_id):
        """
        @api {post} /post/favor/:post_id like a post
        @apiVersion 0.0.1
        @apiName Like a post
        @apiGroup Post
        @apiDescription like a post

        @apiParam {Number} post_id Post's id

        @apiSuccess {Boolean} data true
        """
        user_id = self.json_args.get('user_id', None) or self.current_user.id
        post = Post.query.filter(Post.id == post_id, ~Post.deleted).first()
        if not post: raise ClientError('帖子不存在')

        favor = PostFavor(post_id=post_id, favor_user_id=user_id)
        favor.save()
        self.simpleSuccess()

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

        favor = PostFavor.query.filter(PostFavor.post_id == post_id, PostFavor.favor_user_id == user_id).first()
        if favor: favor.delete()
        self.simpleSuccess()
