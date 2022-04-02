import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// config refresh and load more future
Widget refreshScaffold({required Widget child}) => RefreshConfiguration(
    headerBuilder: () => const WaterDropHeader(), footerBuilder: () => const ClassicFooter(), child: child);
