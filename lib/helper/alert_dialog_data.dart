import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../core/ColorManager.dart';
final Uri _url = Uri.parse('https://flutter.dev');
class AlertDialogData extends StatelessWidget {
  const AlertDialogData({
    super.key,
    required this.wi, required this.he
  });

  final double wi;
  final double he;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: SizedBox(
          height: wi * 0.15,
          child: Image.asset('assets/images/logo.png')),
      //backgroundColor: const Color(0xFF4B556f).withOpacity(0.7),
      title: const Text("4IDeas",style: TextStyle(fontWeight: FontWeight.bold)),
      content: Container(
        constraints: BoxConstraints(maxWidth: wi * 0.9, maxHeight: he * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                // _launchLinkedInURL(url);
              },
              child: const Text(
                  "Tel: +1804-774-0257",style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Text(
                "Email: johnacolani@gmail.com",style: TextStyle(fontWeight: FontWeight.bold),),
            const Text(
                "LinkedIn: johnacolani@gmail.com",style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      // contentPadding: EdgeInsets.zero,

      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  }
