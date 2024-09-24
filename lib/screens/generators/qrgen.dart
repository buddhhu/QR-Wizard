import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';

// ignore: must_be_immutable
class QrDialog extends StatelessWidget {
  final String data;
  ScreenshotController screenshotController = ScreenshotController();

  QrDialog({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "QR Code generated",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrettyQrView.data(
                errorCorrectLevel: QrErrorCorrectLevel.L,
                data: data,
                errorBuilder: (context, error, stackTrace) {
                  return Text(
                    "$error\n\nMax character length is approximately 2500.",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  );
                },
                decoration: PrettyQrDecoration(
                  // ignore: non_const_call_to_literal_constructor
                  image: PrettyQrDecorationImage(
                      image: const AssetImage("assets/icon.png")),
                  shape: PrettyQrSmoothSymbol(
                    roundFactor: 1,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            screenshotController
                .capture(delay: const Duration(milliseconds: 10))
                .then((capturedImage) async {
              await ImageGallerySaver.saveImage(capturedImage!, quality: 100);
              Fluttertoast.showToast(
                  msg: "Saved to gallery", backgroundColor: Colors.red[100]);
            });
          },
          child: Icon(
            Icons.download_rounded,
            size: 30,
            color: Colors.green[300],
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.close_rounded,
            size: 30,
            color: Colors.red[300],
          ),
        )
      ],
    );
  }
}
