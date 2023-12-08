import 'package:flutter/cupertino.dart';
import 'package:quick_math/common/enums/state_enum.dart';
import 'package:quick_math/common/local_pref_config.dart';
import 'package:quick_math/models/achievement_model.dart';
import 'package:quick_math/repositories/user_repositories.dart';

class LeaderboardController extends ChangeNotifier {
  final UserRepository userRepository;
  LeaderboardModel leader = LeaderboardModel();
  LeaderboardController({required this.userRepository});
  StateEnum state = StateEnum.loading;
  String? idUser;

  Future<void>initState()async{
    idUser = await LocalPrefConfig.getString(LocalPrefConstant.idUser);
    leader = await userRepository.getLeaderboardScore();
    state = StateEnum.success;
    notifyListeners();
  }
}