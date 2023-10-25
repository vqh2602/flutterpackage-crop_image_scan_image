// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:serp_document_scanner/orc_scaner/painters/text_recognizer.dart';

class SerpDocumentScannerData {
  String? imagePath;
  List<TextBlock>? textBlock;
  String? text;

  SerpDocumentScannerData({
    this.imagePath,
    this.text,
    required this.textBlock,
  });

  SerpDocumentScannerData copyWith({
    String? imagePath,
    List<TextBlock>? textBlock,
    String? text,
  }) {
    return SerpDocumentScannerData(
      imagePath: imagePath ?? this.imagePath,
      textBlock: textBlock ?? this.textBlock,
      text: text ?? this.text,
    );
  }

  @override
  String toString() =>
      'SerpDocumentScannerData(imagePath: $imagePath, textBlock: $textBlock, text: $text)';
}
