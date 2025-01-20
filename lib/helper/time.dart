DateTime formatTime(String time, String prayerName) {
  // Assuming `time` is in "HH:mm" format
  List<String> timeParts = time.split(':');
  int hour = int.parse(timeParts[0]); // Extract hour part
  int minute = int.parse(timeParts[1]); // Extract minute part

  // Get today's date with the correct hour and minute
  DateTime baseTime = DateTime.now()
      .copyWith(hour: hour, minute: minute, second: 0, microsecond: 0);

  if (prayerName == "Fajr" || prayerName == "Sunrise") {
    // Always AM for Fajr and Sunrise
    return baseTime.isBefore(DateTime.now())
        ? baseTime.add(Duration(days: 1))
        : baseTime;
  } else if (prayerName == "Zohar") {
    // Conditional for Zohar, AM for 11:00, PM for other hours
    if (hour == 11 || hour == 12) {
      return baseTime;
    } else {
      return baseTime.add(Duration(hours: 12));
    }
  } else {
    // Always PM for Asr, Maghrib, and Isha
    return baseTime.add(Duration(hours: 12));
  }
}
