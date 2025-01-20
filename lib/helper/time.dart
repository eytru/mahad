String formatTime(String time, String prayerName) {
  // Assuming `time` is in "HH:mm" format
  int hour = int.parse(time.split(':')[0]); // Extract hour part

  if (prayerName == "Fajr" || prayerName == "Sunrise") {
    return "$time AM"; // Always AM for Fajr and Sunrise
  } else if (prayerName == "Zohar") {
    return (hour == 11) ? "$time AM" : "$time PM"; // Conditional for Zohar
  } else {
    return "$time PM"; // Always PM for Asr, Maghrib, and Isha
  }
}
