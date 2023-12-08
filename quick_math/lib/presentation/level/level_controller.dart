import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quick_math/common/enums/state_enum.dart';
import 'package:quick_math/common/local_pref_config.dart';
import 'package:quick_math/models/level_model.dart';
import 'package:quick_math/models/user_model.dart';
import 'package:quick_math/presentation/app_controller.dart';
import 'package:quick_math/repositories/user_repositories.dart';

class LevelController with ChangeNotifier {
  final UserRepository userRepository;
  UserModel userModel = UserModel();
  final AppController appController;
  LevelController({required this.userRepository,
    required this.appController});

  StateEnum state = StateEnum.loading;
  LevelModel levelSelected = LevelModel();
  Future<void> initState() async {
    try {
      state = StateEnum.loading;
      userModel = appController.userModel ?? UserModel();
    } on Exception catch (e) {
      state = StateEnum.error;
    }
    state = StateEnum.success;
    notifyListeners();
  }

  Future<void> addUser(UserModel createUser) async {
    state = StateEnum.loading;
    final id = await userRepository.addUser(createUser);
    if (id == null) {
      log("null id");
    } else {
      state = StateEnum.loading;
      await LocalPrefConfig.setString(LocalPrefConstant.idUser, id);
      appController.id = id;
      final userData = await userRepository.getUser(id: id);
      if (userData == null) {
        state = StateEnum.error;
        return;
      }
      userModel = userData;
      appController.initState();
      state = StateEnum.success;
      notifyListeners();
    }
  }

  void selectedLevel(String level) {
    int idLevelSelected =
        userModel.levels.indexWhere((element) => element.level == level);

    if (idLevelSelected != -1) {
      levelSelected = userModel.levels[idLevelSelected];
    }
  }
}
