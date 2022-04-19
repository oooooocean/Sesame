SERVER_HOST = 'http://127.0.0.1:8000'

IS_PRODUCT = True

SERVER_CONFIGS = {
    'upload_path': '/store/sesame/' if IS_PRODUCT else '/Users/qiangchen/Desktop/sesame-store/',
    'album_count_limit': 20,
    'photo_count_limit': 500
}

COMMON_CONFIGS = {
    'page_default_limit': 10,
    'nick_name_limit': 20,
    'album_description_limit': 100,
    'album_name_limit': 10,
    'password_min_limit': 8,
    'post_description_limit': 200,
    'post_photo_limit': 9
}

DB_URL = 'mysql+mysqldb://root:BEI1202jing_@127.0.0.1:3306/sesame' if IS_PRODUCT else 'mysql+mysqldb://root:bei1202jing@127.0.0.1:3306/sao'
