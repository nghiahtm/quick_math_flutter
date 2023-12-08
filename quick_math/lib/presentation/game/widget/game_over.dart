import 'package:flutter/material.dart';
import 'package:quick_math/presentation/themes/app_color.dart';
import 'package:quick_math/presentation/themes/app_text_style.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({
    Key? key,
    this.score = 0,
    this.highScore = 0,
    required this.levelMode,
    this.onRefresh, this.onBack,
  }) : super(key: key);
  final int score;
  final int highScore;
  final String levelMode;
  final Function()? onRefresh;
  final Function()? onBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Trò chơi kết thúc",
            style: AppTextStyle.heading1.copyWith(color: AppColor.mainColor),
          ),
          const SizedBox(
            height: 30,
          ),
          Text("Chế độ: $levelMode",
              style: AppTextStyle.heading6.copyWith(color: AppColor.mainColor)),
          Text(
            "Điểm cao nhất: $highScore",
            style: AppTextStyle.heading6.copyWith(color: AppColor.mainColor),
          ),
          Text(
            "Điểm game: $score",
            style: AppTextStyle.heading6.copyWith(color: AppColor.mainColor),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onRefresh,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.mainColor,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.refresh,
                    color: AppColor.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onBack,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.mainColor,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.close,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
