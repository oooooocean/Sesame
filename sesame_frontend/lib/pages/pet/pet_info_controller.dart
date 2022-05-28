part of 'pet_info_page.dart';

class PetInfoController extends GetxController with LoadImageMixin, NetMixin {
  PetInfo? petInfo;
  late TextEditingController nicknameController;
  late TextEditingController signatureController;
  AssetEntity? avatar;
  PetGender? gender;
  DateTime? birthday;
  Variety? variety;
  PetInfoController({this.petInfo}) {
    nicknameController = TextEditingController(text: petInfo?.nickname);
    signatureController = TextEditingController(text: petInfo?.signature);
    gender = petInfo?.gender;
    birthday = petInfo?.birthday;
  }

  @override
  String? shouldRequest() {
    if (avatarProvider == null) return '请选择头像';
    if (nicknameController.text.isEmpty) return '请输入宠物昵称';
    if (gender == null) return '请选择性别';
    if (birthday == null) return '请选择生日';
    return null;
  }

  void choseAvatar() async {
    final config = AssetPickerConfig(
        selectedAssets: avatar != null ? [avatar!] : null,
        maxAssets: 1,
        requestType: RequestType.image);
    final results =
        await AssetPicker.pickAssets(Get.context!, pickerConfig: config);
    if (results == null || results.isEmpty) return;
    avatar = results.first;
    update(['avatar', 'save']);
  }

  ImageProvider? get avatarProvider {
    if (avatar != null) {
      return AssetEntityImageProvider(avatar!);
    }
    if (petInfo?.avatar != null) {
      return NetworkImage(buildNetImageUrl(petInfo!.avatar!));
    }
    return null;
  }

  void choseGender(PetGender gender) {
    if (this.gender == gender) return;
    this.gender = gender;
    update(['gender', 'save']);
  }

  void choseVarity(Variety variety) {
    if (this.variety == variety) return;
    this.variety = variety;
    update(['variety', 'save']);
  }

  void choseBirthday(DateTime birthday) {
    if (this.birthday == birthday) return;
    this.birthday = birthday;
    update(['birthday', 'save']);
  }

  void save() async {
    EasyLoading.show(status: "保存中...");
    bool success = await _mockSubmitResult(avatar != null ? [avatar!] : []);
    if (!success) {
      EasyLoading.showToast('保存失败');
      return;
    }
    EasyLoading.showToast('保存成功');
    // Get.back();
  }

  Future<bool> _mockSubmitResult(List<AssetEntity> files) {
    if (files.isEmpty) {
      return Future.delayed(const Duration(seconds: 0)).then((value) => false);
    }
    // 压缩
    final filesFutures = files.map((entity) {
      Future<Uint8List?> bytes;
      final size = ThumbnailSize(
          (min(Get.width * Get.pixelRatio, entity.size.width)).toInt(),
          (min(Get.height * Get.pixelRatio, entity.size.height).toInt()));
      bytes = entity.thumbnailDataWithSize(size,
          quality: 50, format: ThumbnailFormat.jpeg);
      return bytes.then((value) {
        if (value == null) return null;
        return MultipartFile(value.toList(), filename: entity.title ?? '');
      });
    }).toList();
    return Future.wait(filesFutures).then((files) {
      if (files.isEmpty) {
        return false;
      }
      // 模拟上传代码
      return Future.delayed(const Duration(seconds: 2)).then((value) => true);
    });
  }
}
