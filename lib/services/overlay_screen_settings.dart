import 'dart:async';

import 'package:dyslexia_assistant/providers/should_repaint_overlay_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ocr_services.dart';

class OverlayScreenSettings {
  double height = 0;
  double width = 0;
  Timer? _timer;

  // Private constructor
  OverlayScreenSettings._privateConstructor();

  // Singleton instance
  static final OverlayScreenSettings _instance = OverlayScreenSettings._privateConstructor();

  // Getter to access the singleton instance
  static OverlayScreenSettings get instance => _instance;

  // Method to set the size
  void setSize(double height, double width) {
    this.height = height;
    this.width = width;
  }

  Future<void> onUserDoSomething(WidgetRef ref, double pixelRatio) async {
    if (kDebugMode) {
      print('user is dragging or clicking outside widgets');
    }
    _timer?.cancel();
    bool shouldRepaint = ref.watch(shouldRepaintOverlayProvider);
    if(!shouldRepaint){
      ref.read(shouldRepaintOverlayProvider.notifier).state = true;
    }
    await FlutterOverlayWindow.updateFlag(OverlayFlag.clickThrough);
    _timer = Timer(const Duration(milliseconds: 3000), () async {
      onUserDoNothing(ref, pixelRatio);
    });
    //await FlutterOverlayWindow.resizeOverlay(widthResize.toInt(), heightResize.toInt());
  }
  Future<void> onUserDoNothing(WidgetRef ref, double pixelRatio) async {
   // _timer?.cancel();
    if (kDebugMode) {
      print('user do nothing...');
    }
    //final Uint8List? byte = await FlutterNativeScreenshot.takeCustomScreenshot();
    //await TextRecognitionService.instance.startImageRecognitionFromBytes(byte!, pixelRatio, ref);

    ref.read(shouldRepaintOverlayProvider.notifier).state = false;
    await FlutterOverlayWindow.updateFlag(OverlayFlag.defaultFlag);

    //await FlutterOverlayWindow.resizeOverlay(this.width.toInt(), this.height.toInt());
  }

  Future<void> openOverlay(double height, double width) async {
    setSize(height, width);
    print(height);
    print(width);
    final bool status = await FlutterOverlayWindow.isPermissionGranted();
    if(!status){
      await FlutterOverlayWindow.requestPermission();
    }
    await FlutterOverlayWindow.showOverlay(
        flag: OverlayFlag.defaultFlag,
       alignment: OverlayAlignment.topRight,
      // visibility: NotificationVisibility.visibilityPublic,
       // height: this.height.toInt(),
        //width: this.width.toInt(),
        enableDrag: false
    );
  }
  Future<void> closeOverlay() async {
    final bool isActive = await FlutterOverlayWindow.isActive();
    if(isActive){
      await FlutterOverlayWindow.closeOverlay();
      return;
    }
  }
}
