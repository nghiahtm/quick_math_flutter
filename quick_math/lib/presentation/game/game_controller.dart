import 'package:flutter/foundation.dart';
import 'package:quick_math/models/level_model.dart';
import 'package:quick_math/presentation/app_controller.dart';
import 'package:quick_math/repositories/user_repositories.dart';

class GameController with ChangeNotifier {
  int score = 0;
  LevelModel levelSelected = LevelModel();
  final AppController appController;
  final UserRepository userRepository;


  GameController(
      {required this.userRepository,
      required this.appController,
      this.score = 0});
  void initState() {
    score = 0;
  }

  Future<void> setUser() async {
    String? id = appController.id;
    if (score > levelSelected.highScore) {
      levelSelected.highScore = score;
      await userRepository.setUser(id ?? "", levelSelected);
      levelSelected.highScore = score;
    }
  }
}
