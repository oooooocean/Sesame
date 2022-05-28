from sqlalchemy import Column, Integer, ForeignKey, String, Boolean
from sqlalchemy.orm import relationship
from models.post_model import PostHandlerBase


class PostComment(PostHandlerBase):
    __tablename__ = 'post_comment'
    __post_back_populates__ = 'comments'
    __user_key__ = 'comment_user'

    comment = Column(String(512), nullable=False)
    comment_user_id = Column(Integer, ForeignKey('user.id'))
    deleted = Column(Boolean, default=False)

    comment_user = relationship('User', back_populates='comments')
