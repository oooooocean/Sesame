from views.users.user_views import UserHandler
from views.users.user_pwd_views import UserPasswordHandler

urls = [
    (r'([0-9]+)/?', UserHandler),
    (r'password/?', UserPasswordHandler)
]