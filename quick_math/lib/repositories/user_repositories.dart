import 'package:quick_math/common/enums/level_enum.dart';
import 'package:quick_math/database/user_firestore.dart';
import 'package:quick_math/models/achievement_model.dart';
import 'package:quick_math/models/user_model.dart';

import '../models/level_model.dart';

class UserRepository {
  final UserFireStore fireStore;

  UserRepository({required this.fireStore});

  Future<UserModel?> getUser ({String? id}){
    return fireStore.getUsername(id);
  }

  Future<String?> addUser (UserModel user){
    user.levels = <LevelModel>[];
    user.levels.add(LevelModel(level: LevelEnum.easy));
    user.levels.add(LevelModel(level: LevelEnum.normal));
    user.levels.add(LevelModel(level: LevelEnum.hard));
    return fireStore.addUserName(user);
  }

  Future<void> setUser (String id,LevelModel level){
    return fireStore.setUser(id,level);
  }

  Future<List<LevelModel>> getLevel (String id){
    return fireStore.getLevelUser(id);
  }

  Future<LeaderboardModel> getLeaderboardScore (){
    return fireStore.getLeaders();
  }
}