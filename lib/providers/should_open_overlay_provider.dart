import 'package:flutter_riverpod/flutter_riverpod.dart';

class NativeSettings{
  bool shouldOpen;
  bool alreadyOpenScreenRecording;
  NativeSettings({required this.alreadyOpenScreenRecording, required this.shouldOpen});
}

final NativeSettings nativeSettings =
NativeSettings(alreadyOpenScreenRecording: false, shouldOpen: false);

// Membuat StateProvider untuk boolean 'shouldRepaintOverlay'
final shouldOpenOverlayProvider = StateProvider<NativeSettings>((ref) {
  return NativeSettings(
      alreadyOpenScreenRecording: false,
      shouldOpen: false); // Nilai default di awal adalah false.
});
