from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import scoped_session, sessionmaker, registry
import os

from importlib import import_module

DB_URL = 'mysql+mysqldb://root:bei1202jing@127.0.0.1:3306/sao'

db_engine = create_engine('mysql+mysqldb://root:bei1202jing@127.0.0.1:3306/sao',
                          encoding='utf8',
                          echo=False,
                          future=True)

# registry().generate_base()
BaseDB = declarative_base(db_engine)

sessions = scoped_session(sessionmaker(bind=db_engine, autocommit=False, autoflush=True, expire_on_commit=False))


def init_db():
    path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'models')
    valid_files = []
    for _, __, files in os.walk(path):
        valid_files += [file.split('.')[0] for file in files
                        if '_model' in file and os.path.splitext(file)[1] == '.py']
    print('models: %r' % (valid_files,))
    for file in valid_files:
        import_module('models.' + file)  # 利用导入时, 获取数据库实体类信息
    # BaseDB.metadata.create_all()  # 初始化数据库
