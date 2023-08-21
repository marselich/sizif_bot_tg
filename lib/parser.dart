import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:sizif_bot_tg/constants.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

abstract class Parser {
  static Future<List<Element>> _getQuotesList(int pageNum) async {
    List<Element> quotesList;

    final response = await http.Client().get(Uri.parse(
        "${Constants.quotesUri}${pageNum != 0 ? '/page${pageNum + 1}' : ''}"));

    if (response.statusCode == 200) {
      var document = parseHtmlDocument(response.body);

      quotesList = document
          .getElementsByClassName("b-list-quote2__item-text js-quote-text")
          .cast<Element>();
      // quotesList.addAll(document.getElementsByClassName(
      //     "b-list-quote2__item-text js-quote-text"));
    } else {
      throw Exception();
    }

    return quotesList;
  }

  static Future<String> getRandomQuote() async {
    final randPage = Random().nextInt(23); // до 23 страницы
    final randQuote = randPage != 22
        ? Random().nextInt(20)
        : Random().nextInt(12); // 20 цитат, на 23 странице 12 цитат

    final quotesList = await _getQuotesList(randPage);

    return quotesList[randQuote].innerText;
  }
}
