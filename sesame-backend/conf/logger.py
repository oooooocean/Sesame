from loguru import logger
from tornado.httputil import HTTPServerRequest
from tornado.web import RequestHandler


def config_log():
    """
    日志配置
    Once the file is too old, it's rotated
    :return:
    """
    logger.add('log/log.log', rotation='3 days', level='ERROR', backtrace=False)
    logger.add('log/request.log', format="{time} {level} {message}", rotation='100 MB', filter=lambda x: 'status' in x['message'])


def log_request_error(uid: str, request: HTTPServerRequest):
    request_info = 'uid: %r, requst: %r, query: %r, body %r' % (uid, request, request.query, request.body)
    logger.exception(request_info)


def log_request(handler: RequestHandler):
    status = handler.get_status()
    if status < 400:
        log_method = logger.info
    elif status < 500:
        log_method = logger.warning
    else:
        log_method = logger.error
    request_time = 1000.0 * handler.request.request_time()
    log_method('status: %d, method: %r, uri: %r, ip: %r, author: %r, query: %r, body: %r, time: %2.fms' % (handler.get_status(),
               handler.request.method,
               handler.request.uri, handler.request.remote_ip, handler.request.headers.get('Authorization', None), handler.request.query,
               handler.request.body.decode('utf8'),
               request_time))
