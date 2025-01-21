import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 52, 94),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 52, 94),
        elevation: 0,
        title: const Text('Information'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.white,
        ),
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent, // Ensure taps are detected
          onTap: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0), // Add padding for better touch target
            child: Icon(
              Icons.arrow_back_ios, // Use the arrow with a longer tail
              color: Colors.white, // Set color to white
              size: 20, // Adjust size for better visibility
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'This is the Information Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
