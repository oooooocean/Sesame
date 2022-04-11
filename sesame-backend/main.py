import tornado.ioloop
import tornado.options
import app
from conf.logger import config_log
from conf.db import init_db

if __name__ == '__main__':
    print('🚀')
    config_log()
    init_db()
    tornado.options.parse_command_line()
    app.Application().listen(8000, address='0.0.0.0', xheaders=True)
    tornado.ioloop.IOLoop.current().start()
    print('END SERVE')