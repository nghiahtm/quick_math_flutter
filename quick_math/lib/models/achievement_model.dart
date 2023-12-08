import 'package:quick_math/common/enums/level_enum.dart';
import 'package:quick_math/models/user_model.dart';

class InformationUserScore {
  String? name;
  String? idUser;
  int? highScore;

  InformationUserScore({this.name, this.idUser, this.highScore});

  @override
  String toString() {
    return 'InformationUserScore{name: $name, highScore: $highScore}';
  }
}

class LeaderboardModel {
  List<InformationUserScore> easy = [];
  List<InformationUserScore> normal = [];
  List<InformationUserScore> hard = [];

  @override
  String toString() {
    return 'LeaderboardModel{easy: $easy, normal: $normal, hard: $hard}';
  }

  void addLevel(List<UserModel> rawData) {
    for (final user in rawData) {
      for (final level in user.levels) {
        InformationUserScore infor = InformationUserScore(
            name: user.name, idUser: user.id, highScore: level.highScore);
        if (level.level == LevelEnum.normal) {
          normal.add(infor);
        } else if (level.level == LevelEnum.hard) {
          //infor.hard = LevelModel(highScore: level.highScore);
          hard.add(infor);
        } else {
          // infor.easy = LevelModel(highScore: level.highScore);
          easy.add(infor);
          // log("list easy level: ${easy.toString()}");
        }
      }
    }
    normal.sort((a, b) => b.highScore!.compareTo(a.highScore!));
    easy.sort((a, b) => b.highScore!.compareTo(a.highScore!));
    hard.sort((a, b) => b.highScore!.compareTo(a.highScore!));
  }
}
