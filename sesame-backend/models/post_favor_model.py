from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from models.post_model import PostHandlerBase


class PostFavor(PostHandlerBase):
    __tablename__ = 'post_favor'
    __post_back_populates__ = 'favors'
    __user_key__ = 'favor_user'

    favor_user_id = Column(Integer, ForeignKey('user.id'))
    favor_user = relationship('User', back_populates='favors')

    @classmethod
    def has_favor(cls, user_id, post_id) -> bool:
        return PostFavor.query.filter(PostFavor.post_id == post_id,
                                      PostFavor.favor_user_id == user_id).first() is not None
