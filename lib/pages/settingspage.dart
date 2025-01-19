import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 52, 94),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 52, 94), // Match background color
        elevation: 0, // Remove shadow
      ),
      body: const Center(
        child: Text(
          'This is the Settings Page',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
