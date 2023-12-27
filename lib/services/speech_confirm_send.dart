import 'dart:async';
import 'package:dysistant/api/base_url.dart';
import 'package:dysistant/services/speech.dart';
import 'package:http/http.dart' as http;

class SpeechConfirmToSend {
  static final SpeechConfirmToSend _singleton = SpeechConfirmToSend._internal();
  final SpeechToTextSingleton _speechToText = SpeechToTextSingleton();
  Timer? _timer;
  String _lastRecognizedSpeech = '';

  factory SpeechConfirmToSend() {
    return _singleton;
  }

  SpeechConfirmToSend._internal(){
    initializeSpeech();
  }
  void initializeSpeech() async {
    final allowed =  await _speechToText.initialize();
    if(allowed){
      startListening();
    }
  }
  void startListening() async {
    _speechToText.startListening((result){
      _lastRecognizedSpeech = result.recognizedWords;
      // print(_lastRecognizedSpeech);
      _resetTimer();
    });

  }
  void stopListening() async {
    _speechToText.stopListening();
  }

  void restartListening() async{
    stopListening();
    //print('OH MY BOY I WILL RESTART IT AGAIN...');
    await Future.delayed(Duration(milliseconds: 500));
    startListening();
   // print('RESTARTING.........');
  }

  void _resetTimer() {
    _timer?.cancel();
    //print('IM HERE BRO');
    _timer = Timer(Duration(seconds: 5), () {
     _sendPostRequest();
     // print('&&&&&&&&&&&&&&&&&&&&&&&&');
     // DateTime dateTime = DateTime.now();
     // print(dateTime.second);
     // print(_lastRecognizedSpeech); // ITS GOOD
     // print('&&&&&&&&&&&&&&&&&&&&&&&&');
      restartListening();
    });
  }

  void _sendPostRequest() async {
    final url = Uri.parse('$BASE_URL/voice/get-user-audio/'); // Ganti dengan URL POST Anda
    if (_lastRecognizedSpeech.isNotEmpty) {
      try {
        final response = await http.post(
          url,
          body: {'text': _lastRecognizedSpeech},
        );
        if (response.statusCode == 200) {
          print('Request berhasil dikirim: $_lastRecognizedSpeech');
        } else {
          print('Gagal mengirim request. Status: ${response.statusCode}');
        }
      } catch (e) {
        print('Terjadi kesalahan: $e');
      }
    }
  }
}
