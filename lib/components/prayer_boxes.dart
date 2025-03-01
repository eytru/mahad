import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahad/models/prayer_data.dart';
import 'package:mahad/helper/time.dart'; // Import the helper file
import 'package:intl/intl.dart'; // Import the intl package for date formatting

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

  @override
  Widget build(BuildContext context) {
    // Determine the prayer names with 'Jumma' instead of 'Zohar' if it's Friday or Thursday in Jamaat tab
    final List<String> prayerNames = (isThursday || isFriday) && prayerJamaat
        ? ['Fajr', 'Sunrise', 'Jumma', 'Asr', 'Maghrib', 'Isha']
        : ['Fajr', 'Sunrise', 'Zohar', 'Asr', 'Maghrib', 'Isha'];

    // Determine the prayer times based on the 'prayerBeginning' and 'prayerJamaat' flags
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

    // Format the times using the helper function
    prayerTimes = prayerTimes
        .asMap()
        .map((index, time) {
          DateTime prayerTime = formatTime(time, prayerNames[index]);
          String formattedTime = DateFormat('hh:mm a').format(prayerTime);
          return MapEntry(index, formattedTime);
        })
        .values
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double verticalPadding =
              (constraints.maxHeight - (constraints.maxWidth / 2 * 3)) / 2.75;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 1,
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Icon(
                        index == 0
                            ? CupertinoIcons.moon
                            : (index == 1
                                ? CupertinoIcons.sunrise_fill
                                : (index == 2
                                    ? CupertinoIcons.sun_max_fill
                                    : (index == 3
                                        ? CupertinoIcons.sun_max
                                        : (index == 4
                                            ? CupertinoIcons.sunset_fill
                                            : CupertinoIcons
                                                .moon_stars_fill)))),
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        prayerTimes[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
