from conf.db import sessions, BaseDB
from sqlalchemy.orm import Query
import datetime
from service.utils import camel_case
import enum
from conf.base import PAGE_DEFAULT_LIMIT


class ModelMixin:
    query: Query = sessions.query_property()

    def json_exclude_columns(self) -> list:
        return ['create_time', 'deleted']

    @classmethod
    def paginate(cls, offset=None, limit=PAGE_DEFAULT_LIMIT, *criterion) -> tuple:
        count = cls.query.filter(*criterion).count()
        if offset:
            results = cls.query.filter(*criterion).offset(offset).limit(limit).all()
        else:
            results = cls.query.filter(*criterion).limit(limit).all()
        return count, results

    def to_json(self) -> dict:
        """
        转json
        :return:
        """
        json_dict = {}
        exclude_columns = self.json_exclude_columns()
        for column in self.__table__.columns:
            name = column.name
            if name in exclude_columns:
                break
            key_name = camel_case(name)
            value = getattr(self, name)
            if isinstance(value, datetime.datetime):
                json_dict[key_name] = int(value.timestamp())
            elif isinstance(value.__class__, BaseDB):
                json_dict[key_name] = value.to_json()
            elif isinstance(value, enum.Enum):
                json_dict[key_name] = value.value
            else:
                json_dict[key_name] = value
        return json_dict

    def save(self):
        """
        保存对象
        :return:
        """
        sessions.add(self)
        sessions.commit()
        sessions.close()

    def delete(self):
        """
        删除
        :return:
        """
        sessions.delete(self)
        sessions.commit()
        sessions.close()

    @classmethod
    def saveAll(cls, objs):
        """
        保存对象
        :param objs:
        :return:
        """
        sessions.add_all(objs)
        sessions.commit()
        sessions.close()
