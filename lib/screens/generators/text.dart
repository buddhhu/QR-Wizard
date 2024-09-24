import 'package:flutter/material.dart';
import 'package:qrmaker/screens/generators/qrgen.dart';

class TextToQR extends StatelessWidget {
  TextToQR({super.key});
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                enableSuggestions: false,
                controller: _textController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Input text to convert into QR Code.',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: MaterialButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => AlertDialog(
                            title: Text(
                              "Error",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            content: Text(
                              "Please input some text.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                          transitionDuration: const Duration(milliseconds: 150),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              QrDialog(data: _textController.text),
                          transitionDuration: const Duration(milliseconds: 150),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.check_rounded,
                    size: 30,
                    color: Theme.of(context).primaryColor,
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
