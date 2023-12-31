import 'package:dyslexia_assistant/services/overlay_screen_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityDetector extends ConsumerWidget {
  final Widget child;

  const ActivityDetector({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollStartNotification) {
          // Ketika scroll dimulai
          print('Scroll dimulai');
          OverlayScreenSettings.instance.onUserDoSomething(ref, MediaQuery.of(context).devicePixelRatio);
        } else if (scrollInfo is ScrollUpdateNotification) {
          // Ketika terjadi pembaruan pada scroll
          print('Scroll diperbarui');
          OverlayScreenSettings.instance.onUserDoSomething(ref, MediaQuery.of(context).devicePixelRatio);
        } else if (scrollInfo is ScrollEndNotification) {
          // Ketika scroll selesai
          print('Scroll selesai');
          OverlayScreenSettings.instance.onUserDoSomething(ref, MediaQuery.of(context).devicePixelRatio);
        }
        // True agar notifikasi terus berlanjut ke atas
        return true;
      },
      child: GestureDetector(
        onTap: () {
          print('Tap dimulai');
          OverlayScreenSettings.instance.onUserDoSomething(ref, MediaQuery.of(context).devicePixelRatio);
        },
        onVerticalDragStart: (details) {
          // Ketika drag dimulai secara vertikal
          print('Drag dimulai secara vertikal');
          OverlayScreenSettings.instance.onUserDoSomething(ref, MediaQuery.of(context).devicePixelRatio);
        },
        onVerticalDragUpdate: (details) {
          // Ketika terjadi pembaruan pada drag secara vertikal
          print('Pembaruan pada drag secara vertikal');
          OverlayScreenSettings.instance.onUserDoSomething(ref, MediaQuery.of(context).devicePixelRatio);
        },
        onVerticalDragEnd: (details) {
          // Ketika drag selesai secara vertikal
          print('Drag selesai secara vertikal');
          OverlayScreenSettings.instance.onUserDoSomething(ref, MediaQuery.of(context).devicePixelRatio);
        },
        child: child,
      ),
    );
  }
}