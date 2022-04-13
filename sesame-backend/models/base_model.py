from conf.db import Session, BaseDB
from sqlalchemy.orm import Query
import datetime
from service.utils import camel_case
import enum
from conf.base import PAGE_DEFAULT_LIMIT


class ModelMixin:
    query: Query = Session.query_property()

    def json_exclude_columns(self) -> list:
        """
        转 json 时需要排除的字段
        :return:
        """
        return ['create_time', 'deleted']

    @classmethod
    def paginate(cls, offset=None, limit=PAGE_DEFAULT_LIMIT, *criterion, **kwargs) -> tuple:
        """
        分页查询
        :param offset:
        :param limit:
        :param criterion:
        :return:
        """
        count = cls.query.filter(*criterion).count()

        statement = cls.query.filter(*criterion)
        order_by = kwargs.get('order_by')
        if order_by is not None:
            statement = statement.order_by(order_by)
        if offset:
            statement = statement.offset(offset)
        results = statement.limit(limit).all()
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
                continue
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
        Session.add(self)
        Session.commit()

    def delete(self):
        """
        删除
        :return:
        """
        Session.delete(self)
        Session.commit()

    @classmethod
    def saveAll(cls, objs):
        """
        保存对象
        :param objs:
        :return:
        """
        Session.add_all(objs)
        Session.commit()
