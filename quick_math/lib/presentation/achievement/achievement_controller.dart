import 'package:flutter/cupertino.dart';
import 'package:quick_math/common/enums/state_enum.dart';
import 'package:quick_math/models/level_model.dart';
import 'package:quick_math/presentation/app_controller.dart';
import 'package:quick_math/repositories/user_repositories.dart';

class AchievementController extends ChangeNotifier {
  final UserRepository userRepository;
  final AppController appController;
  StateEnum state = StateEnum.loading;
  AchievementController(
      {required this.userRepository, required this.appController});
  List<LevelModel> levelUser = <LevelModel>[];

  Future<void> initState() async {
    final id = appController.id;
    levelUser = await userRepository.getLevel(id ?? "");
    state = StateEnum.success;
    notifyListeners();
  }
}
