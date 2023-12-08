import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quick_math/database/user_firestore.dart';
import 'package:quick_math/presentation/app_controller.dart';
import 'package:quick_math/presentation/archivement/achievement_controller.dart';
import 'package:quick_math/presentation/game/game_controller.dart';
import 'package:quick_math/presentation/home/home_controller.dart';
import 'package:quick_math/presentation/leader_board/leader_board_controller.dart';
import 'package:quick_math/presentation/level/level_controller.dart';
import 'package:quick_math/repositories/user_repositories.dart';

class Di {
  static List<SingleChildWidget> providers = [
    Provider<UserFireStore>(create: (_) => UserFireStore()),
    Provider<UserRepository>(
        create: (context) => UserRepository(
            fireStore: Provider.of<UserFireStore>(context, listen: false))),
    ChangeNotifierProvider(
        create: (context) => AppController(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            )..initState()),
    ChangeNotifierProvider(create: (_) => HomeController()),
    ChangeNotifierProvider(
        create: (context) => LevelController(
            userRepository: Provider.of<UserRepository>(context, listen: false),
            appController: Provider.of<AppController>(context, listen: false))
          ..initState()),
    ChangeNotifierProvider(
        create: (context) => GameController(
            userRepository: Provider.of<UserRepository>(context, listen: false),
            appController: Provider.of<AppController>(context, listen: false))
          ..initState()),
    ChangeNotifierProvider(
        create: (context) => AchievementController(
            userRepository: Provider.of<UserRepository>(context, listen: false),
            appController: Provider.of<AppController>(context, listen: false))),
    ChangeNotifierProvider(
        create: (context) => LeaderboardController(
          userRepository: Provider.of<UserRepository>(context,listen: false)
        ),)
  ];
}
