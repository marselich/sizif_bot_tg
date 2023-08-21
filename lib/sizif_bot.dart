import 'dart:io' as dartio;
import 'dart:math';

import 'package:sizif_bot_tg/constants.dart';
import 'package:sizif_bot_tg/parser.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class SizifBot {
  Future<void> start() async {
    final telegram = Telegram(Constants.botToken);
    final bot = await telegram.getMe();
    final username = bot.username;

    final teledart = TeleDart(Constants.botToken, Event(username!));

    teledart.start();

    _listeners(teledart);
  }

  void _listeners(TeleDart teledart) {
    teledart.onCommand("start").listen((message) {
      final sendQuote = KeyboardButton(text: Constants.sendQuote);

      final markup = ReplyKeyboardMarkup(
        resizeKeyboard: true,
        keyboard: [
          [sendQuote]
        ],
      );

      message.replyPhoto(
        Constants.sizifPhoto,
        caption: "Терпим...",
        replyMarkup: markup,
      );
    });

    teledart.onMessage(keyword: Constants.sendQuote).listen((message) async {
      final sendQuote = KeyboardButton(text: Constants.sendQuote);

      final markup = ReplyKeyboardMarkup(
        resizeKeyboard: true,
        keyboard: [
          [sendQuote]
        ],
      );

      String randomQuote = await Parser.getRandomQuote();

      message.replyPhoto(
        Constants.sizifPhoto,
        caption: randomQuote,
        replyMarkup: markup,
      );

      final changeMp3 = Random().nextInt(100);

      if (changeMp3 >= 70) {
        message.replyVoice(dartio.File("assets/mp3/music.mp3"));
      }
    });
  }
}
