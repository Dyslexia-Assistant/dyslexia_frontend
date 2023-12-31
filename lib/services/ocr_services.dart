import 'dart:io';
import 'package:dyslexia_assistant/models/text_wrapper.dart';
import 'package:dyslexia_assistant/providers/text_wrapper_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

Uuid uuid = Uuid();

class TextRecognitionService {
  // Buat private constructor
  TextRecognitionService._privateConstructor();
  TextRecognitionScript script = TextRecognitionScript.latin;

  // Singleton instance dari TextRecognizer
  static final TextRecognitionService _instance = TextRecognitionService._privateConstructor();

  // Getter untuk instance singleton
  static TextRecognitionService get instance => _instance;

  // Instance TextRecognizer
  TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  // Getter untuk TextRecognizer
  TextRecognizer get textRecognizer => _textRecognizer;

  void reCreateTextRecognizer() {
    _textRecognizer = TextRecognizer(script: script);
  }
  Future<void> getScreenshot() async {

  }



  Future<void> startImageRecognitionFromBytes(Uint8List bytes, double pixelRatio, WidgetRef ref) async {

    File file = File('${Directory.systemTemp.path}/horrible.png');
    if(file.existsSync()){
      file.deleteSync();
    }
    file.createSync();
    file.writeAsBytesSync(bytes);

    final inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    //print('Size Layar dia: h:${inputImage.metadata!.size.height} w:${inputImage.metadata!.size.width}');
   // recognisedText.text;
    Map<String, TextElementWrapper> mapTextElementWrapper = {};
    Map<String, TextLineWrapper> mapTextLineWrapper = {};
    Map<String, TextBlockWrapper> mapTextBlockWrapper = {};
    // Mengakses teks hasil pemindaian
    for (TextBlock block in recognizedText.blocks) {
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      String textBlockId = uuid.v4();
      mapTextBlockWrapper[textBlockId] = TextBlockWrapper(id: textBlockId, textBlock: block);
      for (TextLine line in block.lines) {
        print('Textline: ${line.text}');
        String textLineId = uuid.v4();
        mapTextLineWrapper[textLineId] = TextLineWrapper(id: textLineId, textLine: line, textBlockId: textBlockId);
        line.elements.forEach((element) {
          String textElementId = uuid.v4();
          mapTextElementWrapper[textElementId] = TextElementWrapper(textLineId: textLineId, textBlockId: textBlockId, id: textElementId, textElement: element);
          print('$element => ${element.boundingBox} and> ${element.text}');
        });
        print(
            'Position of textline in logical:'
                ' (L:${line.boundingBox.left/pixelRatio})'
                ' (T:${line.boundingBox.top/pixelRatio})'); // Mendapatkan posisi x dan y
      }
      print('------------------------');
      print('TextBlock:');
      print(block.boundingBox);
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    }
    TextWrapperState state = TextWrapperState(elements: mapTextElementWrapper, lines: mapTextLineWrapper, blocks: mapTextBlockWrapper);
    ref.read(textWrapperProvider.notifier).state = state;
    dispose();
    reCreateTextRecognizer();
  }

  void changeLanguageScript(String newScript) {
    // Memetakan string ke TextRecognitionScript
    switch (newScript.toLowerCase()) {
      case 'latin':
        script = TextRecognitionScript.latin;
        break;
      case 'chinese':
        script = TextRecognitionScript.chinese;
        break;
      case 'japanese':
        script = TextRecognitionScript.japanese;
        break;
      case 'korean':
        script = TextRecognitionScript.korean;
        break;
      case 'devanagiri':
        script = TextRecognitionScript.devanagiri;
        break;
    // Tambahkan case untuk script bahasa lainnya jika diperlukan
      default:
        script = TextRecognitionScript.latin; // Default script jika tidak sesuai
        break;
    }

    _textRecognizer.close(); // Tutup instance TextRecognizer yang ada
    _textRecognizer = TextRecognizer(script: script); // Buat instance baru dengan script yang baru
  }
  // Metode untuk melepaskan resources saat tidak diperlukan lagi
  void dispose() {
    _textRecognizer.close();
  }
}

void doSomething(){
  //TextRecognitionService.instance.startImageRecognitionFromAssets('assets//images//example.png');

}



