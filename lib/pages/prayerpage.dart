import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mahad/components/prayer_boxes.dart';
import 'package:mahad/models/prayer_data.dart';

class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  PrayerData? prayerDataToday;
  PrayerData? prayerDataTomorrow;

  String currentMonth =
      DateFormat('MMMM').format(DateTime.now()); // e.g., "January"
  String nextMonth = DateFormat('MMMM').format(DateTime.now()
      .add(const Duration(days: 1))); // Handle month change for tomorrow
  int todayDate = DateTime.now().day; // e.g., 19
  int tomorrowDate =
      DateTime.now().add(const Duration(days: 1)).day; // e.g., 20
  String currentDayDate = DateFormat('EEEE d MMMM yyyy').format(DateTime.now());
  String tomorrowDayDate = DateFormat('EEEE d MMMM yyyy')
      .format(DateTime.now().add(const Duration(days: 1)));

  late TabController _tabController; // TabController for dynamic updates
  int selectedTabIndex = 0; // Default to the first tab

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Add observer for lifecycle events
    _tabController = TabController(length: 3, vsync: this);
    _loadDefaultTab();
    fetchPrayerTimes();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    _tabController.dispose();
    super.dispose();
  }

  // Called when the app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Fetch fresh prayer times and load default tab on app resume
      _loadDefaultTab();
      fetchPrayerTimes();
    }
  }

  // Called when the widget is reinserted into the widget tree (e.g., returning to this page)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadDefaultTab();
    fetchPrayerTimes();
  }

  // Load the default tab index from SharedPreferences
  Future<void> _loadDefaultTab() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultPage =
        prefs.getString('defaultPrayerPage') ?? 'Beginning Times';

    setState(() {
      selectedTabIndex = defaultPage == 'Beginning Times' ? 0 : 1;
      _tabController.index = selectedTabIndex; // Set the TabController's index
    });
  }

  Future<void> fetchPrayerTimes() async {
    // Fetch today's prayer times
    QuerySnapshot<Map<String, dynamic>> querySnapshotToday =
        await FirebaseFirestore.instance
            .collection(currentMonth)
            .where('DATE', isEqualTo: todayDate)
            .get();

    if (querySnapshotToday.docs.isNotEmpty) {
      setState(() {
        prayerDataToday =
            PrayerData.fromJson(querySnapshotToday.docs[0].data());
      });
    } else {
      setState(() {
        prayerDataToday =
            PrayerData.empty(); // Fallback in case data is missing
      });
    }

    // Fetch tomorrow's prayer times
    QuerySnapshot<Map<String, dynamic>> querySnapshotTomorrow =
        await FirebaseFirestore.instance
            .collection(nextMonth)
            .where('DATE', isEqualTo: tomorrowDate)
            .get();

    if (querySnapshotTomorrow.docs.isNotEmpty) {
      setState(() {
        prayerDataTomorrow =
            PrayerData.fromJson(querySnapshotTomorrow.docs[0].data());
      });
    } else {
      setState(() {
        prayerDataTomorrow =
            PrayerData.empty(); // Fallback in case data is missing
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 1, 52, 94),
          child: Column(
            children: [
              // Top section with date
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                child: Text(
                  selectedTabIndex == 2
                      ? tomorrowDayDate // Display tomorrow's date on the third tab
                      : currentDayDate, // Display today's date otherwise
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // TabBar with wider and equal-length indicator
              TabBar(
                controller: _tabController, // Attach the TabController
                dividerColor: Colors.transparent,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.5, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 80.0),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: const [
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
                  controller: _tabController, // Attach the TabController
                  children: [
                    SafeArea(
                      bottom: true,
                      child: PrayerBoxes(
                        prayerData: prayerDataToday,
                        prayerBeginning: true,
                        prayerJamaat: false,
                      ),
                    ),
                    SafeArea(
                      bottom: true,
                      child: PrayerBoxes(
                        prayerData: prayerDataToday,
                        prayerBeginning: false,
                        prayerJamaat: true,
                      ),
                    ),
                    SafeArea(
                      bottom: true,
                      child: PrayerBoxes(
                        prayerData: prayerDataTomorrow,
                        prayerBeginning: false,
                        prayerJamaat: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
