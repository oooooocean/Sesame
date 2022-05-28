DateTime convertTimestampToDatetime(dynamic timestamp) {
  int intTimestamp;
  if (timestamp is String) {
    intTimestamp = int.parse(timestamp);
  } else {
    intTimestamp = timestamp;
  }
  return DateTime.fromMillisecondsSinceEpoch(intTimestamp * 1000);
}
