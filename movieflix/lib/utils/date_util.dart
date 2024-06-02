int? getDateDiff(String a, String b) {
  try {
    final date1 = DateTime.parse(a);
    final date2 = DateTime.parse(b);
    return date1.difference(date2).inDays;
  } catch (err) {
    return null;
  }
}
