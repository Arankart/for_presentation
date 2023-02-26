import 'dart:io';

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class TelegramBot {
  TelegramBot._();

  static final TelegramBot _telegramBot = TelegramBot._();

  static TelegramBot get telegramBot => _telegramBot;

  String bot_token = '5872366737:AAGTC_XyfxwYnei-B_JQ_RWfuiEq1aGPEWA';
  String chatId = '';
  String botName = '';

  String? username;

  void sentMssg(String text) async {
    username = (await Telegram(bot_token).getMe()).username;
    var teledart = TeleDart(bot_token, Event(username!));
    teledart.sendMessage(chatId, text);
  }

  void initBot() async {
    username = (await Telegram(bot_token).getMe()).username;
    var teledart = TeleDart(bot_token, Event(username!));
    teledart
        .onMessage(entityType: 'bot_command', keyword: 'start')
        .listen((message) {
      teledart.sendMessage(message.chat.id,
          'Привет, здесь тебе будут приходить напоминания из приложения Задержун, велком!');
      chatId = message.chat.id.toString();
      print("chat id new: " + chatId);
    });
    teledart.start();
  }
}
