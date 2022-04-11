part of 'user_info_set_page.dart';

class UserInfoSetController extends GetxController with LoadImageMixin {
  AssetEntity? avatar;
  UserInfo? userInfo;

  void choseAvatar() {}
  
  ImageProvider? get avatarProvider {
    if (avatar != null) return AssetEntityImageProvider(avatar!);
    if (userInfo?.avatar != null) return NetworkImage(buildNetImageUrl(userInfo!.avatar!));
    return null;
  }
}