from sqlalchemy import Column, Integer, ForeignKey, Enum
from sqlalchemy.orm import relationship
from models.post_model import PostHandlerBase
from enum import IntEnum


class SharePlatform(IntEnum):
    WECHAT = 1
    WECHAT_SESSION = 2


class PostShare(PostHandlerBase):
    __tablename__ = 'post_share'
    __post_back_populates__ = 'shares'
    __user_key__ = 'share_user'

    platform = Column(Enum(SharePlatform), nullable=False)
    share_user_id = Column(Integer, ForeignKey('user.id'))

    share_user = relationship('User', back_populates='shares')
