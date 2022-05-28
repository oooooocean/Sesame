import 'dart:math';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sesame_frontend/components/mixins/keyboard_allocator.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/pet.dart';
import 'package:sesame_frontend/net/net_mixin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
part 'pet_info_controller.dart';
part 'menu_item.dart';

extension PetGenderoDesc on PetGender {
  String get getDescription {
    switch (this) {
      case PetGender.unknow:
        return "未知";
      case PetGender.male:
        return "男孩";
      case PetGender.female:
        return "女孩";
    }
  }

  static List<PetGender> allCase() =>
      [PetGender.male, PetGender.female, PetGender.unknow];
}

extension VarietyDesc on Variety {
  String get getDescription {
    switch (this) {
      case Variety.samoyed:
        return "萨摩耶";
      case Variety.goldenRetriever:
        return "金毛";
    }
  }

  static List<Variety> allCase() => [Variety.samoyed, Variety.goldenRetriever];
}

typedef SelectCallBack = void Function(int selectIndex);

class PetInfoPage extends GetView<PetInfoController>
    with ThemeMixin, KeyboardAllocator {
  PetInfoPage({Key? key}) : super(key: key);

  final nickNameNode = FocusNode();
  final signatureNode = FocusNode();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('宠物档案')),
        body: SafeArea(
            child: GestureDetector(
                onTap: () {
                  nickNameNode.unfocus();
                  signatureNode.unfocus();
                },
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          _avatarItem,
                          const SizedBox(
                            height: 40,
                          ),
                          _nicknameItem,
                          const SizedBox(
                            height: 5,
                          ),
                          _infoList(context),
                          const SizedBox(
                            height: 5,
                          ),
                          _signItem
                        ],
                      ),
                    ),
                    _saveItem,
                  ],
                ))),
      );

  Widget get _avatarItem => OutlinedButton(
        onPressed: controller.choseAvatar,
        child: GetBuilder<PetInfoController>(
          id: 'avatar',
          builder: (_) => controller.avatarProvider == null
              ? const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.portrait, size: 40, color: Colors.grey),
                )
              : ClipOval(
                  child: Image(
                      image: controller.avatarProvider!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover)),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          side: MaterialStateProperty.all(
              BorderSide(color: Colors.grey.withOpacity(0.25), width: 3)),
        ),
      );

  Widget get _nicknameItem => KeyboardActions(
      autoScroll: false,
      config: doneKeyboardConfig([nickNameNode]),
      child: SizedBox(
          height: 80,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text("宠物昵称",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w200)),
                          Expanded(
                              child: TextField(
                                  textInputAction: TextInputAction.done,
                                  focusNode: nickNameNode,
                                  controller: controller.nicknameController,
                                  maxLength: 20,
                                  textAlign: TextAlign.right,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[\w\u4e00-\u9fa5]'))
                                  ],
                                  onChanged: (_) => controller.update(['save']),
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: '输出宠物昵称',
                                  )),
                              flex: 1),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(width: 10),
            ],
          )));

  Future _actionSheet(
          BuildContext context, List<String> titles, SelectCallBack callBack) =>
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
                mainAxisSize: MainAxisSize.min, // 设置最小的弹出
                children: titles
                    .asMap()
                    .entries
                    .map(
                      (e) => ListTile(
                        title: Text(e.value),
                        onTap: () {
                          Navigator.of(context).pop();
                          callBack(e.key);
                        },
                      ),
                    )
                    .toList());
          });

  Widget _infoList(BuildContext context) => SizedBox(
      height: 260,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Colors.white,
              child: Column(
                children: [
                  GetBuilder<PetInfoController>(
                    id: "gender",
                    builder: (controller) {
                      final genders = PetGenderoDesc.allCase();
                      List<String> data =
                          genders.map((e) => e.getDescription).toList();
                      var index = 0;
                      if (controller.gender != null) {
                        index = data
                            .asMap()
                            .entries
                            .firstWhere((element) =>
                                element.value ==
                                controller.gender!.getDescription)
                            .key;
                      }
                      return PetInfoMenuItem(
                        title: '宠物性别',
                        rightSelectedIndex: index,
                        rightSelectionList: data,
                        selectCallBack: (index) =>
                            controller.choseGender(genders[index]),
                      );
                    },
                  ),
                  GetBuilder<PetInfoController>(
                      id: "variety",
                      builder: (_) => PetInfoMenuItem(
                            title: '宠物品种',
                            rightTitle:
                                controller.variety?.getDescription ?? "点击选择品种",
                            onPressed: () {
                              _actionSheet(
                                  context,
                                  VarietyDesc.allCase()
                                      .map((e) => e.getDescription)
                                      .toList(), (selectIndex) {
                                controller.choseVarity(
                                    VarietyDesc.allCase()[selectIndex]);
                              });
                            },
                          )),
                  GetBuilder<PetInfoController>(
                      id: "birthday",
                      builder: (_) => PetInfoMenuItem(
                            title: '出生日期',
                            rightTitle: controller.birthday == null
                                ? "点击选择生日"
                                : DateFormat('yyyy-MM-dd')
                                    .format(controller.birthday!),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030))
                                  .then((value) {
                                if (value != null) {
                                  controller.choseBirthday(value);
                                }
                              });
                            },
                          )),
                  Container(
                    child: const Text(
                      "Tip: 如果不记得生日了，可以填写到家日期哦~",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black38, fontSize: 10),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ));

  Widget get _signItem => KeyboardActions(
      autoScroll: false,
      config: doneKeyboardConfig([nickNameNode]),
      child: SizedBox(
          height: 200,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(
                            child: Text("个性签名",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w200)),
                            height: 20,
                            width: double.infinity,
                          ),
                          Expanded(
                              child: TextField(
                                  textInputAction: TextInputAction.done,
                                  focusNode: signatureNode,
                                  controller: controller.signatureController,
                                  maxLines: 4,
                                  maxLength: 200,
                                  textAlign: TextAlign.left,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[\w\u4e00-\u9fa5]'))
                                  ],
                                  onChanged: (_) => controller.update(['save']),
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: '快写下想对崽崽说的话吧  ',
                                  )),
                              flex: 1),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(width: 10),
            ],
          )));

  Widget get _saveItem => GetBuilder<PetInfoController>(
      id: 'save',
      builder: (_) {
        final enable = controller.shouldRequest() == null;
        final color = enable ? Colors.white : borderColor;
        final color1 = enable ? Colors.pink : borderColor;
        return Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: enable ? controller.save : null,
                    child: Text('保存', style: TextStyle(color: color)),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                        backgroundColor: MaterialStateProperty.all(color1),
                        side: MaterialStateProperty.all(
                            BorderSide(color: color))),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
          ],
        );
      });
}
