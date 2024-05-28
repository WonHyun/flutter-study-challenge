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

final today = DateTime.now();

final List<DateTime> dayList = [
  for (var i = 0; i < maxAfterDay; i++) today.add(Duration(days: i)),
];
