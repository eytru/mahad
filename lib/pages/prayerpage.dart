import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahad/components/prayer_boxes.dart';
import 'package:mahad/models/prayer_data.dart';

class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  PrayerData? prayerData;
  String currentMonth =
      DateFormat('MMMM').format(DateTime.now()); // e.g., "January"
  int todayDate = DateTime.now().day; // e.g., 19
  String currentDayDate = DateFormat('EEEE d MMMM yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    // Fetch prayer times from Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(currentMonth)
        .where('DATE', isEqualTo: todayDate)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If data is found, set the prayer times
      setState(() {
        prayerData = PrayerData.fromJson(querySnapshot.docs[0].data());
      });
    } else {
      // If no data found, set all times to "00:00"
      setState(() {
        prayerData = PrayerData(
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    borderSide: BorderSide(width: 2.5, color: Colors.white),
                    insets: EdgeInsets.symmetric(horizontal: 80.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Column(
                        children: [
                          Text('Beginning', style: TextStyle(fontSize: 15)),
                          Text('Times', style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Text('Jamaat', style: TextStyle(fontSize: 15)),
                          Text('Times', style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Text('Jamaat', style: TextStyle(fontSize: 15)),
                          Text('Tomorrow', style: TextStyle(fontSize: 15)),
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
