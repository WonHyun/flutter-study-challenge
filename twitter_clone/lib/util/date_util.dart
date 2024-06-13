import 'package:intl/intl.dart';

String getMMMMdyFormat(DateTime? date) {
  if (date == null) return "";
  return DateFormat("MMMM d, y").format(date);
}

DateTime? getDateTimeFromMMMMdyFormat(String? date) {
  if (date == null) return null;
  return DateFormat("MMMM d, y").parse(date);
}

String getTimeAgoFormat(DateTime? time) {
  if (time == null) return "";
  final diff = DateTime.now().difference(time);

  if (diff.inDays >= 365) {
    int years = (diff.inDays / 365).floor();
    return '${years}y';
  } else if (diff.inDays >= 30) {
    int months = (diff.inDays / 30).floor();
    return '${months}month';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays}d';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours}h';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes}m';
  } else {
    return 'now';
  }
}

int compareDateTimeDescending(DateTime? a, DateTime? b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return b.compareTo(a);
}
