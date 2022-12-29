import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.code, required this.closeScreen});
  final String code;
  final Function() closeScreen;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              closeScreen();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          title: Text(
            'QR Scanner',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: code,
                size: 180,
                version: QrVersions.auto,
                gapless: false,
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text(
                      "Uh oh! Something went wrong...",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              Text(
                'Scanned Result',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 3,
              ),
              GestureDetector(
                onTap: () async {
                  if (await canLaunchUrl(Uri.parse(code))) {
                    await launchUrl(Uri.parse(code));
                  } else {
                    throw 'Could not launch $code';
                  }
                },
                child: Text(
                  code,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.blue,
                      ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: (Text('Code Coppied'))));
                  },
                  child: Text(
                    'Copy',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
