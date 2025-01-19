import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahad/components/prayer_boxes.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    String currentDayDate = DateFormat(' EEEE d MMMM yyyy ').format(DateTime.now());

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Container(
            color: const Color.fromARGB(255, 1, 52, 94),
            child: Column(
              children: [
                // Top section with date
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: Text(
                    currentDayDate,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // TabBar with wider and equal-length indicator
                const TabBar(
                  dividerColor: Colors.transparent,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3.0, color: Colors.white),
                    insets: EdgeInsets.symmetric(horizontal: 80.0), // Adjust this to make it wider
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Column(
                        children: [
                          Text('Beginning', style: TextStyle(fontSize: 16)),
                          Text('Times', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Text('Jamaat', style: TextStyle(fontSize: 16)),
                          Text('Times', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Text('Jamaat', style: TextStyle(fontSize: 16)),
                          Text('Tomorrow', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                // TabBarView
                Expanded(
                  child: TabBarView(
                    children: [
                      SafeArea(
                        bottom: true,
                        child: PrayerBoxes(),
                      ),
                      SafeArea(
                        bottom: true,
                        child: PrayerBoxes(),
                      ),
                      SafeArea(
                        bottom: true,
                        child: PrayerBoxes(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
