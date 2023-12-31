import 'package:flutter_riverpod/flutter_riverpod.dart';

// Membuat StateProvider untuk boolean 'shouldRepaintOverlay'
final shouldRepaintOverlayProvider = StateProvider<bool>((ref) {
  return false; // Nilai default di awal adalah false.
});