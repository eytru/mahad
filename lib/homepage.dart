import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'pages/calendarpage.dart';
import 'pages/prayerpage.dart';
import 'pages/settingspage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the selected index

  // Pages to display based on the selected index
  final List<Widget> _pages = [
    const PrayerPage(), // Index 0
    const CalendarPage(), // Index 1
    const SettingsPage(), // Index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 52, 94),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 1, 52, 94),
        color: const Color.fromARGB(255, 2, 93, 167),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index
          });
        },
        items: [
          Image.asset(
            'lib/icons/mosque.png',
            width: 25,
            height: 25,
            color: Colors.black, // Optional: Tint the image white
          ),
          Image.asset(
            'lib/icons/timetable.png',
            width: 25,
            height: 25,
            color: Colors.black, // Optional: Tint the image white
          ),
          Image.asset(
            'lib/icons/settings.png',
            width: 25,
            height: 25,
            color: Colors.black, // Optional: Tint the image white
          ),
        ],
      ),
    );
  }
}
