class PrayerData {
  final int date; // Corresponds to the "DATE" column
  final String bFajr; // Corresponds to the "bFAJR" column
  final String sunrise; // Corresponds to the "SUNRISE" column
  final String bZohar; // Corresponds to the "bZOHAR" column
  final String bAsr; // Corresponds to the "bASR" column
  final String bMaghrib; // Corresponds to the "bMAGHRIB" column
  final String bIsha; // Corresponds to the "bISHA" column
  final String fajr; // Corresponds to the "FAJR" column
  final String zohar; // Corresponds to the "ZOHAR" column
  final String asr; // Corresponds to the "ASR" column
  final String maghrib; // Corresponds to the "MAGHRIB" column
  final String isha; // Corresponds to the "ISHA" column

  PrayerData({
    required this.date,
    required this.bFajr,
    required this.sunrise,
    required this.bZohar,
    required this.bAsr,
    required this.bMaghrib,
    required this.bIsha,
    required this.fajr,
    required this.zohar,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  /// Converts the `PrayerData` instance to a JSON-compatible map
  Map<String, dynamic> toJson() => {
        'DATE': date,
        'bFAJR': bFajr,
        'SUNRISE': sunrise,
        'bZOHAR': bZohar,
        'bASR': bAsr,
        'bMAGHRIB': bMaghrib,
        'bISHA': bIsha,
        'FAJR': fajr,
        'ZOHAR': zohar,
        'ASR': asr,
        'MAGHRIB': maghrib,
        'ISHA': isha,
      };

  /// Creates a `PrayerData` instance from a JSON map
  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      date: json['DATE'] ?? 0,
      bFajr: json['bFAJR'] ?? '00:00',
      sunrise: json['SUNRISE'] ?? '00:00',
      bZohar: json['bZOHAR'] ?? '00:00',
      bAsr: json['bASR'] ?? '00:00',
      bMaghrib: json['bMAGHRIB'] ?? '00:00',
      bIsha: json['bISHA'] ?? '00:00',
      fajr: json['FAJR'] ?? '00:00',
      zohar: json['ZOHAR'] ?? '00:00',
      asr: json['ASR'] ?? '00:00',
      maghrib: json['MAGHRIB'] ?? '00:00',
      isha: json['ISHA'] ?? '00:00',
    );
  }
  factory PrayerData.empty() {
    return PrayerData(
      date: 0,
      bFajr: "00:00",
      sunrise: "00:00",
      bZohar: "00:00",
      bAsr: "00:00",
      bMaghrib: "00:00",
      bIsha: "00:00",
      fajr: "00:00",
      zohar: "00:00",
      asr: "00:00",
      maghrib: "00:00",
      isha: "00:00",
    );
  }
}
