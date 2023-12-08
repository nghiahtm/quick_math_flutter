import 'dart:math';

import 'package:quick_math/common/math/game_play.dart';

class EasyMode extends GamePlay {
  final _random = Random();

  EasyMode() {
    num1 = 0 + _random.nextInt(10);
    num2 = 0 + _random.nextInt(10);
  }
  @override
  String gameMulti() {
    return "";
  }

  @override
  String gamePlus() {
    num1 = 0 + _random.nextInt(10);
    num2 = 0 + _random.nextInt(10);
    return "$num1 + $num2";
  }

  @override
  String gameSubtract() {
    num1 = num2 + _random.nextInt(10 - num2);
    return "$num1 - $num2";
  }

  @override
  void play(int randomOperator) {
    switch (randomOperator) {
      case 1: case 3:
        showOperator = gamePlus();
        result = num1 + num2;
        shuffleList(result);
        return;
      case 2:
        showOperator = gameSubtract();
        result = num1 - num2;
        shuffleList(result);
        return;
      default:
        return;
    }
  }
  @override
  void shuffleList(int result){
    results = [result,result + 1,result + 2];
    results.shuffle();
  }
}
