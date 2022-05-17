// ignore: import_of_legacy_library_into_null_safe
import 'dart:ffi';

import 'package:event_bus/event_bus.dart';

class PageAction {
  late Bool refresh;

  PageAction(bool bool);
}

class EventBusUtil {
  static EventBus? _instance;
  static EventBus getInstance() {
    _instance ??= EventBus();
    return _instance!;
  }
}
