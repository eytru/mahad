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

  String currentMonth = DateFormat('MMMM').format(DateTime.now());
  String nextMonth =
      DateFormat('MMMM').format(DateTime.now().add(const Duration(days: 1)));
  int todayDate = DateTime.now().day;
  int tomorrowDate = DateTime.now().add(const Duration(days: 1)).day;
  String currentDayDate = DateFormat('EEEE d MMMM yyyy').format(DateTime.now());
  String tomorrowDayDate = DateFormat('EEEE d MMMM yyyy')
      .format(DateTime.now().add(const Duration(days: 1)));

  late TabController _tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadDefaultTab();
      fetchPrayerTimes();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadDefaultTab();
    fetchPrayerTimes();
  }

  Future<void> _loadDefaultTab() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultPage =
        prefs.getString('defaultPrayerPage') ?? 'Beginning Times';

    setState(() {
      selectedTabIndex = defaultPage == 'Beginning Times' ? 0 : 1;
      _tabController.index = selectedTabIndex;
    });
  }

  Future<void> fetchPrayerTimes() async {
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
        prayerDataToday = PrayerData.empty();
      });
    }

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
        prayerDataTomorrow = PrayerData.empty();
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                child: Text(
                  selectedTabIndex == 2 ? tomorrowDayDate : currentDayDate,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.5, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 80.0),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                      child:
                          Column(children: [Text('Beginning'), Text('Times')])),
                  Tab(child: Column(children: [Text('Jamaat'), Text('Times')])),
                  Tab(
                      child:
                          Column(children: [Text('Jamaat'), Text('Tomorrow')])),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    PrayerBoxes(
                        prayerData: prayerDataToday,
                        prayerBeginning: true,
                        prayerJamaat: false,
                        isThursday: false,
                        isFriday: false),
                    PrayerBoxes(
                        prayerData: prayerDataToday,
                        prayerBeginning: false,
                        prayerJamaat: true,
                        isThursday: false,
                        isFriday: DateFormat('EEEE').format(DateTime.now()) ==
                            'Friday'),
                    PrayerBoxes(
                        prayerData: prayerDataTomorrow,
                        prayerBeginning: false,
                        prayerJamaat: true,
                        isThursday: DateFormat('EEEE').format(DateTime.now()) ==
                            'Thursday',
                        isFriday: false),
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
