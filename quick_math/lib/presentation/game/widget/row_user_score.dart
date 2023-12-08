
import 'package:flutter/material.dart';
import 'package:quick_math/presentation/game/game_controller.dart';
import 'package:quick_math/presentation/themes/app_text_style.dart';

class RowUserScoreWidget extends StatelessWidget {
  const RowUserScoreWidget({
    super.key,
    required this.gameController,
  });

  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Điểm cao: ${gameController.levelSelected.highScore}",
          style: AppTextStyle.heading6.copyWith(fontSize: 22),
        ),
        Text(
          "${gameController.score}",
          style: AppTextStyle.heading6.copyWith(fontSize: 22),
        )
      ],
    );
  }
}