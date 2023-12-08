import 'package:flutter/material.dart';
import 'package:quick_math/presentation/achievement/achievement_screen.dart';
import 'package:quick_math/presentation/game/game_screen.dart';
import 'package:quick_math/presentation/leader_board/leader_board_screen.dart';
import 'package:quick_math/presentation/level/level_screen.dart';
import 'package:quick_math/presentation/routes/route_constant.dart';

Map<String, WidgetBuilder> routesMap = {
  RouteConstant.level: (_) => const LevelScreen(),
  RouteConstant.achievement: (_) => const AchievementScreen(),
  RouteConstant.leader: (_) => const LeaderBoardScreen(),
};

Route? onGenerateRoute(RouteSettings settings) {
  if (settings.name == RouteConstant.game) {
    final args = settings.arguments as Map<String, dynamic>;
    final play = args['game_play'];

    return MaterialPageRoute(builder: (_) {
      return GameScreen(
        gamePlay: play!,
        levelSelected: args['infor_gamePlay'] ?? "",
      );
    });
  }
  return null;
}
