import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quick_math/common/enums/level_enum.dart';
import 'package:quick_math/common/enums/state_enum.dart';
import 'package:quick_math/common/math/easy_mode.dart';
import 'package:quick_math/common/math/game_play.dart';
import 'package:quick_math/common/math/hard_mode.dart';
import 'package:quick_math/common/math/normal_model.dart';
import 'package:quick_math/models/user_model.dart';
import 'package:quick_math/presentation/home/home_controller.dart';
import 'package:quick_math/presentation/level/level_controller.dart';
import 'package:quick_math/presentation/routes/route_constant.dart';
import 'package:quick_math/presentation/themes/app_button.dart';
import 'package:quick_math/presentation/themes/app_color.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final levelController = Provider.of<LevelController>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<LevelController>(builder: (context, level, child) {
                      if (level.state == StateEnum.loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.white,
                          ),
                        );
                      }
                      if (level.appController.id == null) {
                        return Column(
                          children: [
                            const Text(
                              "Hãy nhập tên trước khi chọn cấp độ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: TextField(
                                controller: controller,
                                maxLength: 40,
                                style:
                                    const TextStyle(color: AppColor.mainColor),
                                decoration: const InputDecoration(
                                  fillColor: AppColor.white,
                                  filled: true,
                                  counterText: ""
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Text(
                        "Chào mừng ${level.userModel.name}\n Hãy chọn cấp độ",
                        style: const TextStyle(
                            fontSize: 20,
                            color: AppColor.white,
                            fontWeight: FontWeight.w600),
                      );
                    }),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    AppButton(
                        title: LevelEnum.easy,
                        onPressed: () async {
                          await _checkInformation(levelController, EasyMode(),
                              level: LevelEnum.easy);
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                        title: LevelEnum.normal,
                        onPressed: () async {
                          await _checkInformation(levelController, NormalMode(),
                              level: LevelEnum.normal);
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                        title: LevelEnum.hard,
                        onPressed: () async {
                          await _checkInformation(levelController, HardMode(),
                              level: LevelEnum.hard);
                        }),
                  ],
                ),
              ),
              AppButton(
                  title: "Quay lại",
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkInformation(LevelController levelController, GamePlay play,
      {required String level}) async {
    if (controller.text.isEmpty && levelController.appController.id == null) {
      Fluttertoast.showToast(msg: "Hãy nhập tên");
      return;
    }
    if (levelController.appController.id == null) {
      await levelController.addUser(UserModel(name: controller.text));
    }

    levelController.selectedLevel(level);
    if (context.mounted) {
      Provider.of<HomeController>(context, listen: false).player.pause();
      Navigator.of(context).pushNamed(RouteConstant.game, arguments: {
        "game_play": play,
        "infor_gamePlay": levelController.levelSelected
      });
    }
  }
}
