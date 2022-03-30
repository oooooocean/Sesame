from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    DateTime,
    Enum,
    Boolean,
    BLOB
)
from sqlalchemy.orm import relationship, Query
from models.base_model import ModelMixin
from conf.db import BaseDB
import models.gender
from datetime import datetime


class User(BaseDB, ModelMixin):
    __tablename__ = 'user'

    id = Column(Integer, primary_key=True, autoincrement=True)
    phone = Column(String(11), nullable=False)
    password = Column(BLOB(300), nullable=True)
    create_time = Column(DateTime, default=datetime.now().strftime('%Y-%m-%d %H:%M:%S'), nullable=False)
    deleted = Column(Boolean, default=False, nullable=False)

    info = relationship('UserInfo', back_populates='user', uselist=False)
    albums = relationship('Album', back_populates='user')

    def json_exclude_columns(self):
        return ModelMixin.json_exclude_columns(self) + ['password']


class UserInfo(BaseDB, ModelMixin):
    __tablename__ = 'user_info'

    id = Column(Integer, primary_key=True, autoincrement=True)
    nickname = Column(String(50), nullable=True)
    gender = Column(Enum(models.gender.Gender), nullable=True)
    avatar = Column(String(255), nullable=True)

    user_id = Column(Integer, ForeignKey('user.id'))
    user = relationship('User', back_populates="info")

    def json_exclude_columns(self):
        return ModelMixin.json_exclude_columns(self) + ['user_id']
