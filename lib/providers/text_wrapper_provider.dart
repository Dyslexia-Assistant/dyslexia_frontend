import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/text_wrapper.dart';

//Menyimpan sekumpulan objek dari google_ml_kit_text_recognization
// Update struktur State untuk menggunakan Map daripada List.
class TextWrapperState {
  final Map<String, TextElementWrapper> elements;
  final Map<String, TextLineWrapper> lines;
  final Map<String, TextBlockWrapper> blocks;

  TextWrapperState({
    required this.elements,
    required this.lines,
    required this.blocks,
  });

  // Menambahkan copyWith untuk membuat perubahan pada state.
  TextWrapperState copyWith({
    Map<String, TextElementWrapper>? elements,
    Map<String, TextLineWrapper>? lines,
    Map<String, TextBlockWrapper>? blocks,
  }) {
    return TextWrapperState(
      elements: elements ?? this.elements,
      lines: lines ?? this.lines,
      blocks: blocks ?? this.blocks,
    );
  }
}

// StateNotifier yang akan mengatur state TextRecognitionState
class TextWrapperNotifier extends StateNotifier<TextWrapperState> {
  TextWrapperNotifier()
      : super(TextWrapperState(elements: {}, lines: {}, blocks: {}));

  void addElement(TextElementWrapper element) {
    state = state.copyWith(
      elements: {...state.elements, element.id: element},
    );
  }

  void removeElement(String elementId) {
    final newElements = Map<String, TextElementWrapper>.from(state.elements)
      ..remove(elementId);
    state = state.copyWith(elements: newElements);
  }

  void addLine(TextLineWrapper line) {
    state = state.copyWith(
      lines: {...state.lines, line.id: line},
    );
  }

  void removeLine(String lineId) {
    final newLines = Map<String, TextLineWrapper>.from(state.lines)
      ..remove(lineId);
    state = state.copyWith(lines: newLines);
  }

  void addBlock(TextBlockWrapper block) {
    state = state.copyWith(
      blocks: {...state.blocks, block.id: block},
    );
  }

  void removeBlock(String blockId) {
    final newBlocks = Map<String, TextBlockWrapper>.from(state.blocks)
      ..remove(blockId);
    state = state.copyWith(blocks: newBlocks);
  }
}

// Provider untuk TextRecognitionNotifier.
final textWrapperProvider =
StateNotifierProvider<TextWrapperNotifier, TextWrapperState>((ref) {
  return TextWrapperNotifier();
});