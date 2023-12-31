import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechToTextSingleton {
  static final SpeechToTextSingleton _singleton = SpeechToTextSingleton._internal();
  late stt.SpeechToText _speech;
  bool _isInitialized = false;
  bool _isAlwaysActive = true;
  Timer? _timer;
  Duration reListeningTime = Duration(seconds: 10);
  String locale = 'id-ID';

  factory SpeechToTextSingleton() {
    return _singleton;
  }

  void setSpeechBehaviour(String identifier){
    if(identifier == 'ALWAYS_ACTIVE'){
      _isAlwaysActive = true;
    }
    else{
      _isAlwaysActive = false;
    }
  }

  SpeechToTextSingleton._internal() {
    _speech = stt.SpeechToText();
  }

  stt.SpeechToText get speechInstance {
    return _speech;
  }
  void reset() {
    _speech.cancel(); // Hentikan proses apapun yang sedang berlangsung
    _isInitialized = false; // Reset flag inisialisasi
  }

  Future<bool> initialize() async {
    if (!_isInitialized) {
      bool isAvailable = await _speech.initialize();
      if (isAvailable) {
        _isInitialized = true;
      }
      return isAvailable;
    }
    return _isInitialized;
  }

  void startListening(Function(SpeechRecognitionResult) onResult) async {
    print('DISINI?');
    _isInitialized = true;
    _timer?.cancel();
    await _speech.listen(
      onResult: onResult,
      localeId: locale
    );
    reListening((onResult));
  }

  void reListening(Function(SpeechRecognitionResult) onResult) async {

    if(_isAlwaysActive != true){
      return;
    }
    _timer = Timer(reListeningTime, () async {
       print('RELISTENING...');
       if(_speech.isListening){
         print('IT S MY RETURN');
         return;
       }
       await _speech.stop();
       await Future.delayed(Duration(milliseconds: 500));
       startListening(onResult); // Panggil kembali fungsi startListening setelah 10 detik
    });
  }

  void stopListening() async {
    await _speech.stop();
    _isInitialized = false;
    _timer?.cancel();
    print('CUTE GIRL');
  }

  bool get isListening => _speech.isListening;

  bool get isInitialized => _isInitialized;
}

