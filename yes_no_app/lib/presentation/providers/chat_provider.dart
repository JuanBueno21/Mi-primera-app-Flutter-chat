import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entitis/message.dart';

class ChatProvider extends ChangeNotifier {
  final chatScrollControler = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: "hola amor", fromWho: FromWho.me),
    Message(text: "ya regresaste?", fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith("?")) {
      herReply();
    }

    notifyListeners();
    movesScrollToBotton();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();
    movesScrollToBotton();
  }

  void movesScrollToBotton() async {
    await Future.delayed(const Duration(milliseconds: 300));
    chatScrollControler.animateTo(chatScrollControler.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
