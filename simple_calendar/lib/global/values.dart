const weekday = [
  "SUNDAY",
  "MONDAY",
  "TUESDAY",
  "WEDNESDAY",
  "THURSDAY",
  "FRIDAY",
  "SATURDAY",
];

const maxAfterDay = 30;

final List<DateTime> dayList = [
  for (var i = 0; i < maxAfterDay; i++) DateTime.now().add(Duration(days: i)),
];
