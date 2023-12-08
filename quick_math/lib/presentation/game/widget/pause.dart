import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_math/common/music_constant.dart';
import 'package:quick_math/presentation/home/home_controller.dart';
import 'package:quick_math/presentation/themes/app_button.dart';
import 'package:quick_math/presentation/themes/app_color.dart';
import 'package:quick_math/presentation/themes/app_text_style.dart';

class PauseWidget extends StatelessWidget {
  const PauseWidget({Key? key, required this.onContinue}) : super(key: key);
  final Function() onContinue;
  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.2),
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(24),
            height: 215,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  "Tạm dừng",
                  style: AppTextStyle.heading6.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 12,
                ),
                AppButton(title: "Tiếp tục", onPressed: onContinue),
                const SizedBox(
                  height: 8,
                ),
                AppButton(
                    title: "Thoát",
                    onPressed: () {
                      homeController.player
                          .setAsset(MusicConstant.bg);
                      homeController.player.play();
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                homeController.setPlayMusic();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Icon(
                  homeController.isPlayMusic
                      ? Icons.volume_up_rounded
                      : Icons.volume_off_rounded,
                  color: AppColor.mainColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
