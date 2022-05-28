from sqlalchemy import Column, ForeignKey
from models.base_model import BaseDB, ModelMixin


class PostPhoto(BaseDB, ModelMixin):
    __tablename__ = 'post_photo'

    post_id = Column(ForeignKey('post.id'), primary_key=True)
    photo_id = Column(ForeignKey('photo.id'), primary_key=True)
