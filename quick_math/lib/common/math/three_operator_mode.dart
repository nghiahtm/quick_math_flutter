import 'dart:math';

import 'package:function_tree/function_tree.dart';
import 'package:quick_math/common/math/game_play.dart';

class ThreeOperatorMode extends GamePlay {
  final _random = Random();
  int randomOperator2 = 0;
  ThreeOperatorMode() {
    randomOperator2 = 0 + _random.nextInt(3);
  }
  @override
  String gameMulti() {
    // TODO: implement gameMulti
    throw UnimplementedError();
  }

  @override
  String gamePlus() {
    // TODO: implement gamePlus
    throw UnimplementedError();
  }

  @override
  String gameSubtract() {
    // TODO: implement gameSubtract
    throw UnimplementedError();
  }

  @override
  void play(int randomOperator) {
    randomOperator2 = 1 + _random.nextInt(2);
    num1 = 0 + _random.nextInt(10);
    num2 = 0 + _random.nextInt(10);
    num3 = 0 + _random.nextInt(10);
    showOperator =
        "$num1 ${_checkExpression(randomOperator)} $num2 ${_checkExpression(randomOperator2)} $num3";
    result = showOperator.interpret().toInt();
    shuffleList(result);
  }

  @override
  void shuffleList(int result) {
    results = [result, result + 1, result + 2];
    results.shuffle();
  }

  String _checkExpression(int interRandom) {
    if (interRandom == 3) return "X";
    return operator[interRandom] ?? "";
  }
}
