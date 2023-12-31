import 'package:uuid/uuid.dart';

String generateUUID() {
  // Membuat UUID baru
  final sessionId = Uuid().v4();
  return sessionId;
  // Gunakan sessionId sesuai kebutuhan aplikasi Anda
}