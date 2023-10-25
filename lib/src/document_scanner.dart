// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart' as gcm;
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:serp_document_scanner/orc_scaner/painters/text_recognizer.dart';
import 'package:serp_document_scanner/src/document_model.dart';

class SerpDocumentScanner {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  static Future<SerpDocumentScannerData?> getImageFromCamera(
      {bool? canUseGallery,
      String? androidScanTitle,
      String? androidCropTitle,
      String? androidCropBlackWhiteTitle,
      String? androidCropReset}) async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return null;
    }

    // Generate filepath for saving
    String imagePathResult = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    bool success = false;

    try {
      //Make sure to await the call to detectEdge.
      success = await EdgeDetection.detectEdge(
        imagePathResult,
        canUseGallery: canUseGallery ?? true,
        androidScanTitle: androidScanTitle ??
            'Scanning', // use custom localizations for android
        androidCropTitle: androidCropTitle ?? 'Crop',
        androidCropBlackWhiteTitle: androidCropBlackWhiteTitle ?? 'Black White',
        androidCropReset: androidCropReset ?? 'Reset',
      );

      // print("success: $success");
    } catch (e) {
      debugPrint(e.toString());
    }

    if (success) {
      // imagePath = imagePathResult;
      final inputImage = InputImage.fromFilePath(imagePathResult);
      final instance = SerpDocumentScanner();
      return await instance._processImage(inputImage);
    }
    return null;
  }

  // Future<void> getImageFromGallery() async {
  //   // Generate filepath for saving
  //   String imagePath = join((await getApplicationSupportDirectory()).path,
  //       "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

  //   bool success = false;
  //   try {
  //     //Make sure to await the call to detectEdgeFromGallery.
  //     success = await EdgeDetection.detectEdgeFromGallery(
  //       imagePath,
  //       androidCropTitle: 'Crop', // use custom localizations for android
  //       androidCropBlackWhiteTitle: 'Black White',
  //       androidCropReset: 'Reset',
  //     );
  //     print("success: $success");
  //   } catch (e) {
  //     print(e);
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.

  //   _imagePath = imagePath;
  // }

  Future<SerpDocumentScannerData> _processImage(
      gcm.InputImage inputImage) async {
    RecognizedText recognizedText =
        await _textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    // late Rect rectResult = Rect.zero;
    // late List<Point<int>> cornerPointsResult = [];
    // late List<String> textResult = [];
    // late List<String> languagesResult = [];
    // late List<String> textLines = [];

    // // debugPrint('text all :${recognizedText.text}');
    // for (TextBlock block in recognizedText.blocks) {
    //   rectResult.add(block.boundingBox);
    //   cornerPointsResult = block.cornerPoints;
    //   textResult = block.text;
    //   languagesResult = block.recognizedLanguages;

    //   for (TextLine line in block.lines) {
    //     // Same getters as TextBlock
    //     for (TextElement element in line.elements) {
    //       // Same getters as TextBlock
    //       textLines.add(element.text.toString());
    //     }
    //   }
    // }

    return SerpDocumentScannerData(
      imagePath: inputImage.filePath,
      textBlock: recognizedText.blocks,
      text: text,
    );
  }
}
