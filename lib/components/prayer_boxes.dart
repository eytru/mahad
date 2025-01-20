import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mahad/models/prayer_data.dart';

class PrayerBoxes extends StatelessWidget {
  final PrayerData? prayerData;
  final bool prayerBeginning;
  final bool prayerJamaat;

  const PrayerBoxes({
    super.key,
    this.prayerData,
    required this.prayerBeginning,
    required this.prayerJamaat,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> prayerNames = [
      'Fajr',
      'Sunrise',
      'Zohar',
      'Asr',
      'Maghrib',
      'Isha'
    ];

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

    // If it's the Jamaat times, we could decide to adjust how the times are shown
    // For now, let's use a simple approach and show the same times but with "Jamaat" next to them.
    if (prayerJamaat) {
      prayerTimes = prayerTimes.map((time) => "$time").toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted padding
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
                      const SizedBox(
                          height: 12), // Increased space between text and icon
                      Icon(
                        index == 0 // Fajr case
                            ? CupertinoIcons.moon
                            : (index == 1 // Sunrise case
                                ? CupertinoIcons.sunrise_fill
                                : (index == 2 // Zohar case
                                    ? CupertinoIcons.sun_max_fill
                                    : (index == 3 // Asr case
                                        ? CupertinoIcons.sun_max
                                        : (index == 4 // Maghrib case
                                            ? CupertinoIcons.sunset_fill
                                            : CupertinoIcons
                                                .moon_stars_fill)))), // Isha case
                        color: Colors.white,
                        size: 40, // Increased icon size
                      ),
                      const SizedBox(
                          height: 12), // Increased space between icon and time
                      Text(
                        prayerTimes[index], // Display the correct prayer time
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
