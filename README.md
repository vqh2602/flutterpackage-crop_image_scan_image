
# serp_document_scanner

  thư viện tự nhận dạng tài liệu thông qua camera hoặc hình ảnh. phát triển dựa trên 2 thư viện: edge_detection, google_mlkit_text_recognition, google_mlkit_commons  

## Cấu hình

### iOS

Cần có iOS iOS 13.0 trở lên để sử dụng plugin. Nếu biên dịch cho bất kỳ phiên bản nào thấp hơn 13.0, hãy đảm bảo kiểm tra phiên bản iOS trước khi sử dụng plugin. Thay đổi phiên bản nền tảng tối thiểu thành 13 (hoặc cao hơn) trong tệp `ios/Podfile` của bạn và thông báo/yêu cầu quyền truy cập vào các quyền theo `permission_handler`

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: PermissionGroup.camera
         'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.photos
         'PERMISSION_PHOTOS=1',
      ]

    end
    # End of the permission_handler configuration
  end
end
```

## Fix build on xCode 15

Thêm dòng này vào Podfile trong dự án của bạn:

```
pod 'WeScan', :path => '.symlinks/plugins/edge_detection/ios/WeScan-3.0.0'
```

=> ví dụ như vậy

```
target 'Runner' do
  use_frameworks!
  use_modular_headers!
  pod 'WeScan', :path => '.symlinks/plugins/edge_detection/ios/WeScan-3.0.0'
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

Thêm quyền bên dưới vào `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Can I use the photos please?</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Can I use the photos please?</string>
```

### Android

Mã plugin được viết bằng kotlin 1.8.0 vì vậy điều tương tự cũng phải được đặt cho dự án Android của bạn để biên dịch.
Thay đổi kotlin_version thành 1.8.0 trong tệp `android/build.gradle` của bạn.

```
ext.kotlin_version = '1.8.0'
```

Thay đổi phiên bản Android SDK tối thiểu thành 21 (hoặc cao hơn) trong tệp `android/app/build.gradle` của bạn.

```
minSdkVersion 21
```
## Sử dụng
```
import  'package:serp_document_scanner/serp_document_scanner.dart';
```

```dart
await  SerpDocumentScanner.getImageFromCamera();
```

example: 
```dart
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

```


## Demo

<p align="center">
  <img src="https://raw.githubusercontent.com/sawankumarbundelkhandi/edge_detection/master/screenshots/demo.gif" alt="Demo" style="margin:auto" width="372" height="686">
</p>

## Screenshots

# Android

<div style="text-align: center">
   <table>
      <tr>
         <td style="text-align: center">
            <img src="https://raw.githubusercontent.com/sawankumarbundelkhandi/edge_detection/master/screenshots/android/1.png" width="200"/>
         </td>
         <td style="text-align: center">
            <img src="https://raw.githubusercontent.com/sawankumarbundelkhandi/edge_detection/master/screenshots/android/2.png" width="200" />
         </td>
         <td style="text-align: center">
            <img src="https://raw.githubusercontent.com/sawankumarbundelkhandi/edge_detection/master/screenshots/android/3.png" width="200"/>
         </td>
      </tr>
   </table>
</div>

# iOS

<div style="text-align: center">
   <table>
      <tr>
         <td style="text-align: center">
            <img src="https://raw.githubusercontent.com/sawankumarbundelkhandi/edge_detection/master/screenshots/ios/1.PNG" width="200"/>
         </td>
         <td style="text-align: center">
            <img src="https://raw.githubusercontent.com/sawankumarbundelkhandi/edge_detection/master/screenshots/ios/2.PNG" width="200" />
         </td>
         <td style="text-align: center">
            <img src="https://raw.githubusercontent.com/sawankumarbundelkhandi/edge_detection/master/screenshots/ios/3.PNG" width="200"/>
         </td>
      </tr>
   </table>
</div>
   
   tài liệu được viết cho phiên bản 1.0.0 và các bản dev, beta của nó
   ## Đóng góp ✨

<table>
  <tr>
    <td align="center"><a href="#"><img src="https://avatars.githubusercontent.com/u/62917858?v=4" width="100px;" alt=""/><br /><sub><b>WuangHuy</b></sub></a><br /><a title="Code">🍉</a></td>
  </tr>
</table>