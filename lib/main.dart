import 'package:flutter/material.dart';
import 'package:qr_scanner/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          color: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              height: 1.6),
          headline2: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w300,
              height: 1.6),
          headline3: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w300,
              height: 1.6),
        ),
        primarySwatch: Colors.teal,
      ),
      home: QRScanner(),
    );
  }
}
