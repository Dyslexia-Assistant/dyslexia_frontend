import 'package:uuid/uuid.dart';

import 'command.dart';

class ChatAnswer {
  final String id;
  String answer;
  List<Command> commands;

  ChatAnswer({
    required this.id,
    required this.answer,
    required this.commands,
  });

  factory ChatAnswer.createNew({
    required String answer,
    required List<Command> commands,
  }) {
    var uuid = Uuid();
    return ChatAnswer(
      id: uuid.v4(), // Membuat ID baru menggunakan uuid
      answer: answer,
      commands: commands,
    );
  }

  ChatAnswer copyWith({
    String? id,
    String? answer,
    List<Command>? commands,
  }) {
    return ChatAnswer(
      id: id ?? this.id,
      answer: answer ?? this.answer,
      commands: commands ?? this.commands,
    );
  }
}
