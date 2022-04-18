import 'package:get/get.dart';

class HomeAction {
  final String text;
  HomeAction(this.text);

  static final actions = [githubAction, applyTestAction, contactAction];

  static final githubAction = HomeAction('Github');
  static final applyTestAction = HomeAction('申请测试');
  static final contactAction = HomeAction('联系作者');
}

class HomePageController extends GetxController {
  void tapAction(HomeAction action) {}
}