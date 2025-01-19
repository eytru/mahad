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
      bFajr: json['bFAJR'] ?? '',
      sunrise: json['SUNRISE'] ?? '',
      bZohar: json['bZOHAR'] ?? '',
      bAsr: json['bASR'] ?? '',
      bMaghrib: json['bMAGHRIB'] ?? '',
      bIsha: json['bISHA'] ?? '',
      fajr: json['FAJR'] ?? '',
      zohar: json['ZOHAR'] ?? '',
      asr: json['ASR'] ?? '',
      maghrib: json['MAGHRIB'] ?? '',
      isha: json['ISHA'] ?? '',
    );
  }
}