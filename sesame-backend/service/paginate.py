from tornado.web import RequestHandler
from conf.base import COMMON_CONFIGS
from common.exception import ClientError


def paginate(request: RequestHandler, model_cls, *criterion, **kwargs) -> tuple:
    """
    分页结果
    :param request:
    :param model_cls: 实体类
    :param criterion: 实体类筛选条件, 用于 filter 方法的参数
    :return:
    """
    criterion = list(criterion)

    limit = int(request.get_query_argument('limit', COMMON_CONFIGS['page_default_limit']))
    page = request.get_query_argument('page', None)
    start = request.get_query_argument('start', None)

    if not (page or start): raise ClientError('page, start 不能同时为空')

    offset = None
    if page:
        offset = int(page) * limit
    else:
        criterion.append(model_cls.id > int(start))

    return model_cls.paginate(offset, limit, *criterion, **kwargs)


def paginate_json(request: RequestHandler, model_cls, *criterion) -> dict:
    count, results = paginate(request, model_cls, *criterion)
    return {'count': count, 'results': [item.to_json() for item in results]}
