
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

//simpan foreign key
class TextElementWrapper {
  final String id;
  final String textLineId;
  final String textBlockId;
  final TextElement textElement;
  const TextElementWrapper({required this.textLineId,
    required this.textBlockId, required this.id, required this.textElement});
}
class TextLineWrapper{
  final String id;
  final TextLine textLine;
  final String textBlockId;
  const TextLineWrapper({required this.id, required this.textLine, required this.textBlockId});
}
class TextBlockWrapper{
  final String id;
  final TextBlock textBlock;
  const TextBlockWrapper({required this.id, required this.textBlock});
}
