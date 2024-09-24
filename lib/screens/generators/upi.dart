import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrmaker/screens/generators/qrgen.dart';

class UPIToQR extends StatelessWidget {
  UPIToQR({super.key});
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _merchantNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fontStyle = TextStyle(
      fontSize: 18,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
    );
    var data = "upi://pay?";

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
                controller: _upiIdController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'UPI ID',
                  labelStyle: fontStyle,
                  floatingLabelStyle: fontStyle,
                ),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                controller: _merchantNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Merchant Name',
                  labelStyle: fontStyle,
                  floatingLabelStyle: fontStyle,
                ),
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                enableSuggestions: false,
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Amount',
                  labelStyle: fontStyle,
                  floatingLabelStyle: fontStyle,
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
                    if (_upiIdController.text.isNotEmpty) {
                      data += "pa=${_upiIdController.text}&";
                    }
                    if (_merchantNameController.text.isNotEmpty) {
                      data += "pn=${_merchantNameController.text}&";
                    }
                    if (_amountController.text.isNotEmpty) {
                      data += "am=${_amountController.text}&";
                    }
                    data += "cu=INR";
                    if (_upiIdController.text.isEmpty |
                        _merchantNameController.text.isEmpty) {
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
                              "UPI ID and Merchant name are required.",
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
                          pageBuilder: (_, __, ___) => QrDialog(
                            data: data,
                          ),
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
