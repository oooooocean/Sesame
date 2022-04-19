from views.base.base_views import AuthBaseHandler
from models.post_model import Post
from service.paginate import paginate


class PostsHandler(AuthBaseHandler):
    def get(self, user_id):
        """
        @api {get} /posts/:user_id All post of particular user.
        @apiVersion 0.0.1
        @apiName Fetch all posts
        @apiGroup Post
        @apiDescription Fetch all post of particular user.

        @apiParam {Number} [user_id] User's id.

        @apiSuccess {Object[]} posts list of post.
        """
        user_id = user_id or self.current_user.id
        count, posts = paginate(self, Post, Post.owner_id == user_id, ~Post.deleted, order_by=Post.id.desc())
        self.success({'count': count, 'results': [post.to_json() for post in posts]})