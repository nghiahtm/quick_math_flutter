import 'dart:math';

import 'package:quick_math/common/math/game_play.dart';

class NormalMode extends GamePlay{
  final _random = Random();

  NormalMode(){
    num1 = 5 + _random.nextInt(15);
    num2 = 5 + _random.nextInt(15);
  }
  @override
  String gameMulti() {
    num1 = 5 + _random.nextInt(5);
    num2 = 5 + _random.nextInt(5);
    return "$num1 * $num2";
  }

  @override
  String gamePlus() {
    num1 = _random.nextInt(10);
    num2 = _random.nextInt(10);
    return "$num1 + $num2";
  }

  @override
  String gameSubtract() {
    num1 = _random.nextInt(10);
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
    if(result % 10 == 0){
      results = [result,result + 10,result - 10];
    }else{
      results = [result,result + 1,result + 2];
    }
    results.shuffle();
  }
  
}