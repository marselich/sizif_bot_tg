import 'package:sizif_bot_tg/sizif_bot.dart';

void main(List<String> arguments) async {
  final bot = SizifBot();
  await bot.start();
  print("Bot activated");
}
