import 'dart:typed_data';
import 'dart:ui';
import 'package:dyslexia_assistant/providers/should_open_overlay_provider.dart';
import 'package:dyslexia_assistant/providers/should_repaint_overlay_provider.dart';
import 'package:dyslexia_assistant/providers/text_wrapper_provider.dart';
import 'package:dyslexia_assistant/services/background.dart';
import 'package:dyslexia_assistant/services/ocr_services.dart';
import 'package:dyslexia_assistant/services/overlay_screen_settings.dart';
import 'package:dyslexia_assistant/utils/text_screen_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';


class Call {
  final String callerName;
  final String callTime;

  Call({required this.callerName, required this.callTime});
}

class OverlayScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OverlayScreenState();
  }
}

class _OverlayScreenState extends ConsumerState<OverlayScreen> {

  final ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageFileBytes;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Call> callList = [
    Call(callerName: 'John Doe', callTime: '10:00 AM'),
    Call(callerName: 'Jane Smith', callTime: '11:30 AM'),
    Call(callerName: 'Ucok', callTime: '12:34 AM')
    // Tambahkan entri panggilan lainnya sesuai kebutuhan
  ];

  Future<void> _captureAndSaveScreenshot() async {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    print('pixel ratio $pixelRatio');
    try {
      print('hei tayo=---------------------=----------------------------------------------------------------------------');
   //   final Uint8List? rush = await FlutterNativeScreenshot.takeCustomScreenshot();
     // final res = await FlutterNativeScreenshot.takeScreenshot();
      print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          'xxxNICExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
     // print('res path: $res');
      print('rush:');
      //print(rush);
    //  File imageFile = File(res!);
    //  Uint8List uint8list = await imageFile.readAsBytes();
      print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          'xxxNICExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      //print('Screenshot tersimpan: ${imageFile.}');
    } catch (e) {
      print('error: $e');
      print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          'xxxFAILURExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('HELLO WORLD');

  }



  @override
  Widget build(BuildContext context) {
    bool shouldRepaint = ref.watch(shouldRepaintOverlayProvider);

    TextWrapperState textWrapperState = ref.watch(textWrapperProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: scaffoldKey ,
      body: Stack(
            children: [
              if(!shouldRepaint)Stack(
                children: [
                  for(var entry in textWrapperState.lines.entries)
                    Positioned(
                        left: TextScreenUtil.convertPhysicalToLogicalPixel
                          (entry.value.textLine.boundingBox.left,
                            MediaQuery.of(context).devicePixelRatio),
                        top: TextScreenUtil.convertPhysicalToLogicalPixel
                          (entry.value.textLine.boundingBox.top,
                            MediaQuery.of(context).devicePixelRatio)+56,
                        child: Text(
                          entry.value.textLine.text,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                              TextScreenUtil.convertPhysicalToLogicalPixel(
                                  entry.value.textLine.boundingBox.size.height ,
                                  MediaQuery.of(context).devicePixelRatio),
                              backgroundColor: Colors.blue.shade800
                          ),
                        )
                          ),
                ],
              ),
              Positioned(bottom: 200, right: 80, child: ElevatedButton(
                onPressed: () async {
                  bool shouldRepaint = ref.watch(shouldRepaintOverlayProvider);
                  //_captureAndSaveScreenshot();
                  print('MENANGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG');
                  final startService = await FlutterNativeScreenshot.startService();
                  final res = await FlutterNativeScreenshot.getScreenshotResources();
                  if(res == 'REQUEST SCREENSHOT RESOURCES APPROVED') {
                  FlutterNativeScreenshot.flutterScreenStream.startScreenStream((p0) {
                    if(!shouldRepaint)
                    TextRecognitionService.instance.startImageRecognitionFromBytes(
                        p0, MediaQuery.devicePixelRatioOf(context), ref);
                  });
                }},
                child: Icon(Icons.face),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                ),
              ),)
            ],
          ),
        );
  }
}
