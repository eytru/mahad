import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrayerBoxes extends StatelessWidget {
  const PrayerBoxes({super.key});

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
                      const SizedBox(height: 12), // Increased space between text and icon
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
                                            : CupertinoIcons.moon_stars_fill)))), // Isha case
                        color: Colors.white,
                        size: 40, // Increased icon size
                      ),
                      const SizedBox(height: 12), // Increased space between icon and time
                      Text(
                        '12:00 AM', // Placeholder time
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
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
