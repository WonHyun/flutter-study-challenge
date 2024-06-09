import 'package:intl/intl.dart';

String getMMMMdyFormat(DateTime? date) {
  if (date == null) return "";
  return DateFormat("MMMM d, y").format(date);
}

DateTime? getDateTimeFromMMMMdyFormat(String? date) {
  if (date == null) return null;
  return DateFormat("MMMM d, y").parse(date);
}
