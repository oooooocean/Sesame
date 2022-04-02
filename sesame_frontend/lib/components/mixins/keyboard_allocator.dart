import 'package:flutter/cupertino.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

mixin KeyboardAllocator on Widget {
  KeyboardActionsConfig doneKeyboardConfig(List<FocusNode> nodes) =>
      KeyboardActionsConfig(actions: nodes.map((node) => KeyboardActionsItem(focusNode: node)).toList());
}
