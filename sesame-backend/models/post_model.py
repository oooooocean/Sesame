from models.base_model import BaseDB, ModelMixin
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from time import time
from models.relationship_models import PostPhoto


class Post(BaseDB, ModelMixin):
    __tablename__ = 'post'

    id = Column(Integer, primary_key=True, autoincrement=True)
    description = Column(String(512), nullable=False)
    create_time = Column(Integer, default=int(time()), nullable=False)
    update_time = Column(Integer, default=int(time()), nullable=False)
    deleted = Column(Boolean, default=False, nullable=False)

    owner_id = Column(Integer, ForeignKey('user.id'))

    owner = relationship('User', back_populates='posts')
    photos = relationship('Photo', secondary=PostPhoto.__tablename__, back_populates='posts')
    favors = relationship('PostFavor', back_populates='post')

    def json_exclude_columns(self):
        return ['deleted']

    def to_json(self) -> dict:
        json_dict = ModelMixin.to_json(self)
        json_dict['photos'] = [photo.to_json() for photo in self.photos]
        json_dict['owner'] = self.owner.info.to_json()
        return json_dict


class PostFavor(BaseDB, ModelMixin):
    __tablename__ = 'post_favor'

    id = Column(Integer, primary_key=True, autoincrement=True)
    create_time = Column(Integer, default=int(time()), nullable=False)
    post_id = Column(Integer, ForeignKey('post.id'))
    favor_user_id = Column(Integer, ForeignKey('user.id'))

    post = relationship('Post', back_populates='favors')
    favor_user = relationship('User', back_populates='favors')

    def to_json(self) -> dict:
        json_dict = ModelMixin.to_json(self)
        json_dict['favor_user'] = self.favor_user.info.to_json()
        return json_dict
