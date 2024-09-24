import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrmaker/screens/generators/text.dart';
import 'package:qrmaker/screens/generators/upi.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/icon.png",
              width: 30.0,
              height: 30.0,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "QR-Wizard",
              style: TextStyle(
                fontSize: 30,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => TextToQR(),
                        transitionDuration: const Duration(milliseconds: 150),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ))
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.resolveWith(
                    (states) => const EdgeInsets.all(20),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.text_snippet_rounded,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Text to QR Code",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => UPIToQR(),
                        transitionDuration: const Duration(milliseconds: 150),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ))
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.resolveWith(
                    (states) => const EdgeInsets.all(20),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.payment_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "UPI ID to QR Code",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
