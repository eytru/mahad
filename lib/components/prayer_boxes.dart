import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahad/models/prayer_data.dart';
import 'package:mahad/helper/time.dart';
import 'package:intl/intl.dart';

class PrayerBoxes extends StatelessWidget {
  final PrayerData? prayerData;
  final bool prayerBeginning;
  final bool prayerJamaat;
  final bool isThursday;
  final bool isFriday;

  const PrayerBoxes({
    super.key,
    this.prayerData,
    required this.prayerBeginning,
    required this.prayerJamaat,
    this.isThursday = false,
    this.isFriday = false,
  });

  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.height < 750;
  }

  bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 700; // Adjust for iPads
  }

  @override
  Widget build(BuildContext context) {
    final List<String> prayerNames = (isThursday || isFriday) && prayerJamaat
        ? ['Fajr', 'Sunrise', 'Jumma', 'Asr', 'Maghrib', 'Isha']
        : ['Fajr', 'Sunrise', 'Zohar', 'Asr', 'Maghrib', 'Isha'];

    List<String> prayerTimes = prayerBeginning
        ? [
            prayerData?.bFajr ?? "00:00",
            prayerData?.sunrise ?? "00:00",
            prayerData?.bZohar ?? "00:00",
            prayerData?.bAsr ?? "00:00",
            prayerData?.bMaghrib ?? "00:00",
            prayerData?.bIsha ?? "00:00"
          ]
        : [
            prayerData?.fajr ?? "00:00",
            prayerData?.sunrise ?? "00:00",
            prayerData?.zohar ?? "00:00",
            prayerData?.asr ?? "00:00",
            prayerData?.maghrib ?? "00:00",
            prayerData?.isha ?? "00:00"
          ];

    prayerTimes = prayerTimes
        .asMap()
        .map((index, time) {
          DateTime prayerTime = formatTime(time, prayerNames[index]);
          String formattedTime = DateFormat('hh:mm a').format(prayerTime);
          return MapEntry(index, formattedTime);
        })
        .values
        .toList();

    bool smallScreen = isSmallScreen(context);
    bool largeScreen = isLargeScreen(context);

    double textSize = smallScreen
        ? 20
        : largeScreen
            ? 28
            : 25;
    double timeTextSize = smallScreen
        ? 18
        : largeScreen
            ? 26
            : 25;
    double iconSize = smallScreen
        ? 35
        : largeScreen
            ? 50
            : 45;
    double spacing = smallScreen
        ? 10.0
        : largeScreen
            ? 15.0
            : 12.0;
    double childAspectRatio = smallScreen
        ? 1.2
        : largeScreen
            ? 1.4
            : 1.0;
    int crossAxisCount = largeScreen ? 2 : 2;

    return Padding(
      padding: MediaQuery.of(context).size.height < 750
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
          : const EdgeInsets.only(left: 10, right: 10, top: 25),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: smallScreen
                  ? 12.0
                  : largeScreen
                      ? 20.0
                      : 16.0,
              mainAxisSpacing: smallScreen
                  ? 12.0
                  : largeScreen
                      ? 20.0
                      : 16.0,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: prayerNames.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF005CB2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      prayerNames[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spacing),
                    Icon(
                      _getPrayerIcon(index),
                      color: Colors.white,
                      size: iconSize,
                    ),
                    SizedBox(height: spacing),
                    Text(
                      prayerTimes[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: timeTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _getPrayerIcon(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.moon;
      case 1:
        return CupertinoIcons.sunrise_fill;
      case 2:
        return CupertinoIcons.sun_max_fill;
      case 3:
        return CupertinoIcons.sun_max;
      case 4:
        return CupertinoIcons.sunset_fill;
      case 5:
        return CupertinoIcons.moon_stars_fill;
      default:
        return CupertinoIcons.circle_fill;
    }
  }
}
