import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat_answer.dart';

class ChatMapNotifier extends StateNotifier<Map<String, ChatAnswer>> {
  ChatMapNotifier(Map<String, ChatAnswer> state) : super(state);

  void addChatAnswer(ChatAnswer chatAnswer) {
    state = {...state, chatAnswer.id: chatAnswer};
  }

  void removeChatAnswer(String id) {
    state = Map.from(state)..remove(id);
  }

  void updateChatAnswer(String id, ChatAnswer newChatAnswer) {
    if (state.containsKey(id)) {
      state = Map.from(state)..[id] = newChatAnswer.copyWith(id: id);
    }
  }
}

final chatAnswerMapProvider = StateNotifierProvider<ChatMapNotifier, Map<String, ChatAnswer>>((ref) {
  return ChatMapNotifier({});
});