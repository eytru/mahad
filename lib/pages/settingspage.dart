import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'info.dart'; // Import the InfoPage

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Define the dropdown options
  final List<String> prayerOptions = ['Beginning Times', 'Jamaat Times'];
  String? selectedOption; // Holds the current selected option

  @override
  void initState() {
    super.initState();
    _loadDefaultPrayerPage();
  }

  // Load saved option from SharedPreferences
  Future<void> _loadDefaultPrayerPage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString('defaultPrayerPage') ?? prayerOptions[0];
    });
  }

  // Save selected option to SharedPreferences
  Future<void> _saveDefaultPrayerPage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultPrayerPage', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 52, 94),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 52, 94),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20), // Padding around the body
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Aligns children toward the top
            children: [
              SizedBox(height: 50), // Adds space from the top

              // Information Section with slightly raised effect
              Container(
                height: 70, // Manually set the height of the button
                child: Card(
                  elevation: 8, // Slightly raised effect
                  color: const Color.fromARGB(255, 1, 52, 94),
                  child: ListTile(
                    leading: const ImageIcon(
                      AssetImage('lib/icons/info.png'),
                      size: 25,
                      color: Colors.white,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // To space the text and icon
                      children: const [
                        Text(
                          'Information',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios, // Arrow facing to the right
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const InfoPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin =
                                Offset(1.0, 0.0); // Slide in from right
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Default Prayer Page Dropdown with slightly raised effect
              Container(
                height: 70, // Manually set the height of the button
                child: Card(
                  elevation: 8, // Slightly raised effect
                  color: const Color.fromARGB(255, 1, 52, 94),
                  child: ListTile(
                    leading: const ImageIcon(
                      AssetImage('lib/icons/mosque.png'),
                      size: 25,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Default Page',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0), // Padding around the dropdown
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedOption,
                            isDense: true, // Make the dropdown compact
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.white),
                            items: prayerOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedOption = newValue;
                              });
                              if (newValue != null) {
                                _saveDefaultPrayerPage(newValue);
                              }
                            },
                            dropdownColor: const Color.fromARGB(255, 1, 52, 94),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
