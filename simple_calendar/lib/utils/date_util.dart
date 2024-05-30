import 'package:intl/intl.dart';

String getTimeString(int time) {
  return time.toString().padLeft(2, "0");
}

String getYYYYMMDD(DateTime time) {
  return DateFormat("yyyy-MM-dd").format(time);
}

String getHHMM(DateTime time) {
  return DateFormat("HH:mm").format(time);
}

DateTime getDateTimeFromYearsToMinute(DateTime time) {
  return DateTime(time.year, time.month, time.day, time.hour, time.minute);
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

DateTime adjustNow(DateTime now, int minuteInterval) {
  int roundedMinutes = ((now.minute / minuteInterval).round()) * minuteInterval;

  if (roundedMinutes == 60 ||
      (now.hour == 23 && now.minute >= 60 - minuteInterval)) {
    return DateTime(now.year, now.month, now.day + 1, 0, 0);
  }
  return DateTime(now.year, now.month, now.day, now.hour, roundedMinutes);
}
