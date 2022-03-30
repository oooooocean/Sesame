import os
import conf


def save_files(file_metas, in_rel_path):
    """
    保存文件
    :param file_metas: 文件信息
    :param in_rel_path: 路径
    :return:
    """
    file_name_list = []
    for meta in file_metas:
        file_name = meta['filename']
        file_path = os.path.join(in_rel_path, file_name)
        file_name_list.append(file_name)

        with open(file_path, 'wb') as file:
            file.write(meta['body'])
    return file_name_list


def save_images(image_metas) -> [str]:
    """
    保存图片到本地
    :param image_metas: 图片元数据
    :return: 图片的完整link
    """
    if len(image_metas) == 0:
        return []
    cwd = os.getcwd()
    save_image_path = os.path.join(cwd, 'static/upload/')
    file_name_list = save_files(image_metas, save_image_path)
    return [conf.base.SERVER_HOST + '/static/upload/' + i for i in file_name_list]


def camel_case(string: str) -> str:
    """
    转驼峰
    abc_def -> Abc Def -> AbcDef -> abcDef
    """
    from re import sub
    string = sub(r'(_|-)+', ' ', string).title().replace(' ', '')
    return string[0].lower() + string[1:]


def check_code(code):
    """
    检查验证码
    """
    return code == '123456'
