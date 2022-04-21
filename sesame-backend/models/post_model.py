from models.base_model import BaseDB, ModelMixin
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship, declared_attr
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
    comments = relationship('PostComment', back_populates='post')
    shares = relationship('PostShare', back_populates='post')

    def json_exclude_columns(self):
        return ['deleted']

    def to_json(self) -> dict:
        json_dict = ModelMixin.to_json(self)
        json_dict['photos'] = [photo.to_json() for photo in self.photos]
        json_dict['owner'] = self.owner.info.to_json()
        json_dict['commentCount'] = len(self.comments)
        json_dict['shareCount'] = len(self.shares)
        json_dict['favorCount'] = len(self.favors)
        return json_dict


class PostHandlerBase(BaseDB, ModelMixin):
    __abstract__ = True
    __post_back_populates__ = ''
    __user_key__ = ''

    id = Column(Integer, primary_key=True, autoincrement=True)
    create_time = Column(Integer, default=int(time()), nullable=False)

    @declared_attr
    def post_id(self):
        return Column(Integer, ForeignKey('post.id'))

    @declared_attr
    def post(self):
        return relationship('Post', back_populates=self.__post_back_populates__)

    def to_json(self) -> dict:
        json_dict = ModelMixin.to_json(self)
        json_dict[self.__user_key__] = self.__getattribute__(self.__user_key__).info.to_json()
        return json_dict
