import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchPhone(String phone) async {
    if (!await launchUrl(
      Uri(scheme: 'tel', path: phone),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $phone');
    }
  }

  void _showQrCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Image.asset('lib/icons/whatsappqr.jpg'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                foregroundColor: Colors.black,
              ),
              child: const Text("Close", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 27,
        backgroundColor: Color.fromARGB(255, 1, 52, 94),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
          highlightColor: Colors.transparent,
          splashColor: Color.fromARGB(255, 1, 52, 94),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 1, 52, 94),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Move content up
        children: [
          const SizedBox(
              height: 100), // Adjust this value to move everything up
          SafeArea(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // Align to top
                  children: [
                    Image.asset(
                      'lib/icons/Al-Mahadul-Islami-CenteredCropped.png',
                      scale: 10,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      "Al Mahad ul Islami\nDorset Street\nBradford\nBD5 0LT",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/icons/telephone.png',
                          color: Colors.white,
                          scale: 1.8,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 8)),
                        RichText(
                          text: TextSpan(
                            text: "07898 481297",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchPhone("07898481297"),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/icons/antenna.png',
                          color: Colors.white,
                          scale: 1.7,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 8)),
                        Text(
                          "Radio: 456.625",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/icons/whatsapp.png',
                          color: Colors.white,
                          scale: 1.5,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 8)),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Tap ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              TextSpan(
                                text: "here",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _showQrCode(context),
                              ),
                              TextSpan(
                                text: " to join our WhatsApp group",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/icons/emasjid.png',
                          color: Colors.white,
                          scale: 4,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 5)),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Tap ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              TextSpan(
                                text: "here",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _launchUrl(
                                        Uri.parse(
                                            "https://emasjidlive.co.uk/almahadulislami"),
                                      ),
                              ),
                              TextSpan(
                                text: " to listen to our eMasjid live link",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.25,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Masjid Account Details",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 4)),
                          Text(
                            "Account Name:\nAl Mahad ul islami\nAccount No: 34522052\nSort Code: 40-13-15",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
