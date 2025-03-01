import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:hijri/hijri_calendar.dart'; // Hijri calendar package

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with WidgetsBindingObserver {
  final GlobalKey<ScrollSnapListState> _scrollSnapListKey = GlobalKey();
  int currentMonthIndex = DateTime.now().month - 1;
  late PDFViewController _pdfViewController;
  Uint8List? _pdfBytes;
  bool isRamadan = false; // Track if it's Ramadan

  final List<String> _months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void initState() {
    super.initState();
    _checkHijriMonth();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Function to check if it's the 9th month (Ramadan) in the Hijri calendar
  Future<void> _checkHijriMonth() async {
    try {
      HijriCalendar todayHijri = HijriCalendar.now();
      isRamadan = todayHijri.hMonth == 9;

      // Load the correct PDF based on the Hijri month
      String pdfPath =
          isRamadan ? 'lib/pdf/ramadan.pdf' : 'lib/pdf/timetable.pdf';
      _pdfBytes = (await rootBundle.load(pdfPath)).buffer.asUint8List();

      setState(() {});
    } catch (e) {
      throw Exception('Error loading PDF: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        currentMonthIndex = DateTime.now().month - 1;
        _scrollSnapListKey.currentState?.focusToItem(currentMonthIndex);
        _pdfViewController.setPage(currentMonthIndex);
      });
    }
  }

  Widget _buildMonthItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              height: 45,
              width: 75,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 2, 93, 167),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  _months[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SafeArea(
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height > 670
                    ? MediaQuery.of(context).size.height * 0.60
                    : MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.95,
                child: _pdfBytes != null
                    ? PDFView(
                        pdfData: _pdfBytes!,
                        defaultPage: currentMonthIndex,
                        swipeHorizontal: true,
                        onViewCreated: (PDFViewController pdfViewController) {
                          setState(() {
                            _pdfViewController = pdfViewController;
                          });
                        },
                        onPageChanged: (int? page, int? total) {
                          setState(() {
                            currentMonthIndex = page ?? 0;
                            _scrollSnapListKey.currentState
                                ?.focusToItem(currentMonthIndex);
                          });
                        },
                      )
                    : const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
        ),
        // Hide month scroll list if it's Ramadan
        if (!isRamadan)
          SizedBox(
            height: 100,
            child: ScrollSnapList(
              key: _scrollSnapListKey,
              itemBuilder: _buildMonthItem,
              itemSize: 100,
              dynamicItemSize: true,
              dynamicItemOpacity: 0.7,
              onItemFocus: (item) {
                setState(() {
                  currentMonthIndex = item;
                });
                _pdfViewController.setPage(currentMonthIndex);
              },
              initialIndex: currentMonthIndex.toDouble(),
              itemCount: _months.length,
            ),
          ),
      ],
    );
  }
}
