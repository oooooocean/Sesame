from views.base.base_views import AuthBaseHandler
from models.post_comment_model import PostComment
from models.post_model import Post
from common.exception import ClientError
from service.validator import validate_str
from conf.base import COMMON_CONFIGS
from service.paginate import paginate_json


class PostCommentHandler(AuthBaseHandler):

    def get(self, post_id):
        """
        @api {get} /post/post_id/comment/ All comments of particular post
        @apiVersion 0.0.1
        @apiName Post comments
        @apiGroup Post
        @apiDescription Fetch all comments of particular post

        @apiParam {Number} post_id Post's id.

        @apiSuccessExample {json} Success-Response:
             {
                "count": 1,
                "results": [
                    {
                        "id": 1,
                        "comment": "💪🏻奥利给",
                        "commentUserId": 1,
                        "postId": 1,
                        "commentUser": {
                            "nickname": "陈芝麻",
                            "gender": 2,
                            "avatar": "202204141150360.png"
                        }
                    }
                ]
            }
        """
        return self.success(
            paginate_json(self, PostComment, PostComment.post_id == post_id, order_by=PostComment.id.desc()))

    def post(self, post_id):
        """
        @api {post} /post/:post_id/comment Publish a comment
        @apiVersion 0.0.1
        @apiName Publish comment
        @apiGroup Post
        @apiDescription Publish a comment

        @apiParam {Number} post_id Post's id
        @apiBody {String} comment comment
        @apiBody {String} [user_id] user's id

        @apiSuccess {Boolean} data true or false
        """
        comment = self.json_args.get('comment', None)
        ok, msg = validate_str(comment, '评论', COMMON_CONFIGS['post_comment_limit'])
        if not ok: raise ClientError(msg)

        post = Post.query.filter(Post.id == post_id, ~Post.deleted).first()
        if not post: raise ClientError('帖子不存在')

        user_id = self.json_args.get('user_id', None) or self.current_user.id
        post_comment = PostComment(comment=comment, comment_user_id=user_id, post_id=post_id)
        post_comment.save()

        self.success(post_comment.to_json())
