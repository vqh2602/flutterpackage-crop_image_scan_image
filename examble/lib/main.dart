import 'dart:io';

import 'package:flutter/material.dart';
import 'package:serp_document_scanner/serp_document_scanner.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SerpDocumentScannerData? data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    data = await SerpDocumentScanner.getImageFromCamera();
                    debugPrint(data?.text);
                    setState(() {});
                  },
                  child: const Text('Scan'),
                ),
              ),
              const SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: getImageFromGallery,
              //     child: const Text('Upload'),
              //   ),
              // ),
              const SizedBox(height: 20),
              const Text('Cropped image path:'),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                child: Text(
                  data?.imagePath ?? 'trống',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Visibility(
                visible: data?.imagePath != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    File(data?.imagePath ?? ''),
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
