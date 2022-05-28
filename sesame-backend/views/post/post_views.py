from views.base.base_views import AuthBaseHandler
from service.validator import validate_post_description
from common.exception import ClientError
from conf.base import COMMON_CONFIGS
from models.post_model import Post
from models.relationship_models import PostPhoto


def _validate_photo(photo_ids):
    if not photo_ids or len(photo_ids) not in range(1, COMMON_CONFIGS['post_photo_limit']):
        return False, '图片数量必须是1-9张'
    return True, None


class PostHandler(AuthBaseHandler):

    def get(self, post_id):
        """
        @api {get} /post/:post_id Fetch particular post
        @apiVersion 0.0.1
        @apiName Fetch the post
        @apiGroup Post
        @apiDescription Fetch particular post.

        @apiParam {Number} [post_id] Post's id

        @apiSuccess {Object} post the post data.
        """
        user_id = self.get_argument('user_id', None) or self.current_user.id
        post = Post.query.filter(Post.id == post_id, Post.owner_id == user_id, ~Post.deleted).first()
        if not post:
            raise ClientError('帖子不存在')
        else:
            return self.success(post.to_json())

    def post(self, post_id):
        """
        @api {post} /post/:post_id Publish or Modify a post
        @apiVersion 0.0.1
        @apiName Publish or Modify a post
        @apiGroup Post
        @apiDescription Publish or Modify a post.  Parameter description and photo_ids are required.

        @apiParam {Number} [post_id] Post's id
        @apiBody {String} description Post's description
        @apiBody {Number[]} photo_ids Post's photos from user's album.
        @apiQuery {Number} [user_id] User's id.

        @apiSuccess {Object} post Post data.
        @apiSuccessExample {json} Success-Response:
            {
            "id": 4,
            "description": "而世之奇伟、瑰怪，非常之观，常在于险远，而人之所罕至焉，故非有志者不能至也。",
            "createTime": 1650348276,
            "updateTime": 1650348276,
            "ownerId": 1,
            "photos": [
                    {
                        "id": 3,
                        "name": "202204131521290.png",
                        "description": null,
                        "favor": false,
                        "albumId": 1
                    }
                ]
            }
        """
        description = self.json_args.get('description', None)
        photo_ids = self.json_args.get('photo_ids', None)
        user_id = self.json_args.get('user_id') or self.current_user.id
        if post_id:
            self._modify(user_id, post_id, description, photo_ids)
        else:
            self._add(user_id, description, photo_ids)

    def _add(self, user_id, description, photo_ids):
        ok, msg = validate_post_description(description)
        if not ok: raise ClientError(msg)
        ok, msg = _validate_photo(photo_ids)
        if not ok: raise ClientError(msg)

        post = Post(description=description, owner_id=user_id)
        post.save()
        post_photos = [PostPhoto(photo_id=photo_id, post_id=post.id) for photo_id in photo_ids]
        PostPhoto.save_all(post_photos)
        return self.success(post.to_json())

    def _modify(self, user_id, post_id, description, photo_ids):
        post = Post.query.filter(Post.id == post_id, Post.owner_id == user_id).first()
        if not post: raise ClientError('帖子不存在')
        ok, _ = validate_post_description(description)
        if ok: post.description = description

        ok, msg = _validate_photo(photo_ids)
        if ok:
            PostPhoto.query.filter(PostPhoto.post_id == post_id).delete()
            post_photos = [PostPhoto(photo_id=photo_id, post_id=post.id) for photo_id in photo_ids]
            PostPhoto.save_all(post_photos)
        return self.success(post.to_json())
