part of 'user_info_set_page.dart';

class UserInfoSetController extends GetxController with LoadImageMixin, NetMixin, RegisterFlowMixin {
  late TextEditingController nicknameController;
  AssetEntity? avatar;
  UserInfo? userInfo;
  Gender? gender;

  UserInfoSetController({this.userInfo}) {
    nicknameController = TextEditingController(text: userInfo?.nickname);
    gender = userInfo?.gender;
  }

  void save() async {
    final userId = (await User.cached())?.id;
    final api = postFormData(
        'user/$userId',
        {'nickname': nicknameController.text, 'gender': (gender!.index + 1).toString()},
        avatar != null ? [avatar!] : [],
        (data) => User.fromJson(data));
    request<User>(api, success: (user) {
      final launch = Get.find<LaunchService>();
      launch.updateUser(user);

      final result = nextRegisterStep();
      if (!result) Get.back();
    });
  }

  @override
  String? shouldRequest() {
    if (avatarProvider == null) return 'Please chose your avatar';
    if (nicknameController.text.isEmpty) return 'Please enter your nickname';
    if (gender == null) return 'Please chose your gender';
    return null;
  }

  void choseAvatar() async {
    final config = AssetPickerConfig(
        selectedAssets: avatar != null ? [avatar!] : null, maxAssets: 1, requestType: RequestType.image);
    final results = await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    avatar = results.first;
    update(['avatar', 'next']);
  }

  void choseGender(Gender gender) {
    if (this.gender == gender) return;
    this.gender = gender;
    update(['gender', 'next']);
  }

  ImageProvider? get avatarProvider {
    if (avatar != null) return AssetEntityImageProvider(avatar!);
    if (userInfo?.avatar != null) return NetworkImage(buildNetImageUrl(userInfo!.avatar!));
    return null;
  }
}
