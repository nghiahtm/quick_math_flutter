abstract class GamePlay{
  int num1 = 0;
  int num2 = 0;
  List<int> results = [];
  String showOperator = "";
  int errorNumber = 0;
  int result = 0;

  String gamePlus();
  String gameSubtract();
  String gameMulti();
  void play(int randomOperator);
  void shuffleList(int result);
}