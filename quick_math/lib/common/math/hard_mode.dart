import 'dart:math';

import 'package:quick_math/common/math/game_play.dart';

class HardMode extends GamePlay {
  final _random = Random();

  HardMode(){
    num1 = 10 + _random.nextInt(30);
    num2 = 10 + _random.nextInt(30);
  }
  @override
  String gameMulti() {
    num1 = 10 + _random.nextInt(20);
    num2 = 10 + _random.nextInt(20);
    return "$num1 * $num2";
  }

  @override
  String gamePlus() {
    num1 = 10 + _random.nextInt(30);
    num2 = 10 + _random.nextInt(30);
    return "$num1 + $num2";
  }

  @override
  String gameSubtract() {
    num1 = 10 + _random.nextInt(30);
    num2 = 10 + _random.nextInt(30);
    return "$num1 - $num2";
  }

  @override
  void play(int randomOperator) {
    switch (randomOperator) {
      case 1:
        showOperator = gamePlus();
        result = num1 + num2;
        shuffleList(result);
        return;
      case 2:
        showOperator = gameSubtract();
        result = num1 - num2;
        shuffleList(result);
        return;
      case 3:
        showOperator = gameMulti();
        result = num1 * num2;
        shuffleList(result);
        return;
      default:
        return;
    }
  }

  @override
  void shuffleList(int result) {
    results = [result,result + 10,result + 11];
    results.shuffle();
  }
  
}