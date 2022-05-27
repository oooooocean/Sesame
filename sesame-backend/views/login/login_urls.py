import views.login.login_views as login_views

urls = [
    (r'/?', login_views.LoginHandler)  # 设置映射关系
]