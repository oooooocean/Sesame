import tornado.ioloop
import tornado.options
import app
from conf.logger import config_log
from conf.db import init_db
from tornado.options import define, options

define('port', default=8000, help='run on the given port', type=int)

if __name__ == '__main__':
    print('🚀')
    config_log()
    init_db()
    tornado.options.parse_command_line()
    app.Application().listen(port=options.port, xheaders=True)
    tornado.ioloop.IOLoop.current().start()
    print('END SERVE')