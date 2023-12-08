import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_math/common/firestore_config.dart';
import 'package:quick_math/common/local_pref_config.dart';
import 'package:quick_math/models/achievement_model.dart';
import 'package:quick_math/models/level_model.dart';
import 'package:quick_math/models/user_model.dart';

class UserFireStore {
  final CollectionReference _users =
      FireStoreConfig.fireStore!.collection('username');

  Future<UserModel> getUsername(String? id) async {
    if (id == null || id.isEmpty) {
      return UserModel();
    }
    final getData = await _users.doc(id).get();
    final levelUser = await _users.doc(id).collection("level").get();

    if (getData.data() == null) {
      LocalPrefConfig.removeString(LocalPrefConstant.idUser);
      return UserModel();
    }
    Map<String, dynamic> data = getData.data() as Map<String, dynamic>;
    data['levels'] = levelUser.docs.map((e) {
      Map<String, dynamic> json = e.data();
      json['idLevels'] = e.id;
      return json;
    }).toList();
    return UserModel.fromJson(data);
  }

  Future<String?> addUserName(UserModel user) async {
    try {
      final newUser = await _users.add(user.toJson());
      if (user.id == null) {
        user.id = newUser.id;
        await _users.doc(user.id).set({"id": user.id}, SetOptions(merge: true));
      }
      final levelUser = _users.doc(newUser.id).collection("level");
      for (int i = 0; i < user.levels.length; i++) {
        final doc = await levelUser.add(user.levels[i].toJson());
        _users
            .doc(newUser.id)
            .collection("level")
            .doc(doc.id)
            .set({'idLevels': doc.id}, SetOptions(merge: true));
      }
      return newUser.id;
    } on FirebaseException catch (e) {
      log("Exception: $e");
    }
    return null;
  }

  Future<void> setUser(String? idUser, LevelModel level) async {
    try {
      await _users
          .doc(idUser)
          .collection("level")
          .doc(level.idLevel)
          .set(level.toJson());
    } on FirebaseException catch (e) {
      log("Exception: $e");
    }
  }

  Future<List<LevelModel>> getLevelUser(String? idUser) async {
    final levelUser = <LevelModel>[];
    try {
      final collection = await _users.doc(idUser).collection("level").get();
      final dataList = collection.docs.map((e) => e.data()).toList();
      for (int i = 0; i < dataList.length; i++) {
        levelUser.add(LevelModel.fromJsom(dataList[i]));
      }
    } on FirebaseException catch (e) {
      log("Exception: $e");
    }
    return levelUser;
  }

  Future<LeaderboardModel> getLeaders() async {
    List<UserModel> rawUser = <UserModel>[];
    final collectionUser = await _users.get();
    final dataList = collectionUser.docs.map((e) => e.data()).toList();
    for (final objectUser in dataList) {
      objectUser as Map<String, dynamic>;
      UserModel userModel = UserModel.fromJson(objectUser);
      QuerySnapshot<Map<String, dynamic>> levelCollection =
          await _users.doc(userModel.id).collection("level").get();
      final dataLevel = levelCollection.docs.map((e) => e.data()).toList();
      userModel.levels = List.generate(
          dataLevel.length, (index) => LevelModel.fromJsom(dataLevel[index]));
      rawUser.add(userModel);
    }
    LeaderboardModel leader = LeaderboardModel()..addLevel(rawUser);
    return leader;
  }
}
