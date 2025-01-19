
class PrayerData {
  String asar;
  int day;
  String fajar;
  String isha;
  //String jumuah;
  String maghrib;
  String sehriEnds;
  String sunRise;
  String zohar;
  String bAsar;
  String bFajar;
  String bIsha;
  String bMaghrib;
  String bZohar;

  PrayerData({
    required this.asar,
    required this.day,
    required this.fajar,
    required this.isha,
    //required this.jumuah,
    required this.maghrib,
    required this.sehriEnds,
    required this.sunRise,
    required this.zohar,
    required this.bAsar,
    required this.bFajar,
    required this.bIsha,
    required this.bMaghrib,
    required this.bZohar,
  });

  Map<String, dynamic> toJson() => {
        'Asar': asar,
        'Day': day,
        'Fajar': fajar,
        'Isha': isha,
        //'Jumuah': jumuah,
        'Maghrib': maghrib,
        'Sehri Ends': sehriEnds,
        'Sun Rise': sunRise,
        'Zohar': zohar,
        'bAsar': bAsar,
        'bFajar': bFajar,
        'bIsha': bIsha,
        'bMaghrib': bMaghrib,
        'bZohar': bZohar,
      };

  static PrayerData fromJson(Map<String, dynamic> json) => PrayerData(
        asar: json['Asar'],
        day: json['Day'],
        fajar: json['Fajar'],
        isha: json['Isha'],
        //jumuah: json["Jumua'h"],
        maghrib: json['Maghrib'],
        sehriEnds: json['Sehri Ends'],
        sunRise: json['Sun Rise'],
        zohar: json['Zohar'],
        bAsar: json['bAsar'],
        bFajar: json['bFajar'],
        bIsha: json['bIsha'],
        bMaghrib: json['bMaghrib'],
        bZohar: json['bZohar'],
      );
}