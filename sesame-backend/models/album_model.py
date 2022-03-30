import conf.db
from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    Boolean
)
from sqlalchemy.orm import relationship
from models.base_model import ModelMixin
from time import time


class Album(conf.db.BaseDB, ModelMixin):
    __tablename__ = 'album'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(255), nullable=False)
    create_time = Column(Integer, default=int(time()), nullable=False)
    deleted = Column(Boolean, default=False, nullable=False)

    user_id = Column(Integer, ForeignKey('user.id'))

    user = relationship('User', back_populates='albums')
    photos = relationship('Photo', back_populates='album', uselist=True)

    def json_exclude_columns(self):
        return ModelMixin.json_exclude_columns(self) + ['user_id']


class Photo(conf.db.BaseDB, ModelMixin):
    __tablename__ = 'photo'

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(255), nullable=False)
    create_time = Column(Integer, default=int(time()), nullable=False)
    deleted = Column(Boolean, default=False, nullable=False)

    album_id = Column(Integer, ForeignKey('album.id'))

    album = relationship('Album', back_populates='photos')

    def json_exclude_columns(self):
        return ModelMixin.json_exclude_columns(self) + ['user_id']
