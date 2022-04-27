import 'package:date_format/date_format.dart';

extension DateTimeExtension on DateTime {
  String get yyyymmdd => formatDate(this, [yyyy, '-', mm, '-', dd]);

  String get yyyymmddhhmm => formatDate(this, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
}
