
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  final isRamadan = HijriCalendar.now().hMonth == 9;
  final List<String> _months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  void initState() {
    super.initState();
    _loadPdfBytes();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadPdfBytes() async {
    try {
      if (isRamadan) {
        final fileName = 'ramadan.pdf';
        try {
          // Explicitly specify the custom storage bucket.
          final storage = FirebaseStorage.instanceFor(
            bucket: 'gs://mahad-5fc63.firebasestorage.app',
          );
          // Reference the file inside that bucket.
          final ref = storage.ref().child(fileName);
          const int maxPdfSize = 10 * 1024 * 1024; // 10MB file size limit
          final data =
              await ref.getData(maxPdfSize).timeout(const Duration(seconds: 7));
          _pdfBytes = data;
        } catch (e) {
          // Fall back to local timetable.pdf
          _pdfBytes = (await rootBundle.load('lib/pdf/timetable.pdf'))
              .buffer
              .asUint8List();
        }
      } else {
        _pdfBytes = (await rootBundle.load('lib/pdf/timetable.pdf'))
            .buffer
            .asUint8List();
      }
      if (mounted) {
        setState(() {});
      }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 7.5),
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 595 / 842, // A4 aspect ratio
                  child: _pdfBytes != null
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                            maxHeight: MediaQuery.of(context).size.height,
                          ),
                          child: PDFView(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            pdfData: _pdfBytes!,
                            defaultPage: currentMonthIndex,
                            swipeHorizontal: true,
                            fitPolicy: FitPolicy.BOTH,
                            onViewCreated:
                                (PDFViewController pdfViewController) {
                              setState(
                                () {
                                  _pdfViewController = pdfViewController;
                                },
                              );
                            },
                            onPageChanged: (int? page, int? total) {
                              setState(
                                () {
                                  currentMonthIndex = page!;
                                  _scrollSnapListKey.currentState
                                      ?.focusToItem(page);
                                },
                              );
                            },
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          if (!isRamadan)
            SizedBox(
              height: 90,
              child: ScrollSnapList(
                key: _scrollSnapListKey,
                itemBuilder: _buildMonthItem,
                itemSize: 140,
                dynamicItemSize: true,
                dynamicItemOpacity: 0.7,
                onItemFocus: (item) {
                  setState(
                    () {
                      currentMonthIndex = item.toInt();
                    },
                  );
                  _pdfViewController.setPage(currentMonthIndex);
                },
                initialIndex: currentMonthIndex.toDouble(),
                itemCount: _months.length,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMonthItem(BuildContext context, int index) {
    return Container(
      padding: MediaQuery.of(context).size.height > 750
          ? const EdgeInsets.only(top: 3)
          : const EdgeInsets.only(top: 15),
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            Container(
              height: 55,
              width: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  _months[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
