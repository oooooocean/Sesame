from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from models.post_model import PostHandlerBase


class PostFavor(PostHandlerBase):
    __tablename__ = 'post_favor'
    __post_back_populates__ = 'favors'
    __user_key__ = 'favor_user'

    favor_user_id = Column(Integer, ForeignKey('user.id'))
    favor_user = relationship('User', back_populates='favors')
