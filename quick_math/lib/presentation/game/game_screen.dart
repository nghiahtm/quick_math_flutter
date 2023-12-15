import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_math/common/math/game_play.dart';
import 'package:quick_math/common/music_constant.dart';
import 'package:quick_math/models/level_model.dart';
import 'package:quick_math/presentation/game/game_controller.dart';
import 'package:quick_math/presentation/game/widget/game_over.dart';
import 'package:quick_math/presentation/game/widget/main_game.dart';
import 'package:quick_math/presentation/game/widget/pause.dart';
import 'package:quick_math/presentation/game/widget/progress_bar.dart';
import 'package:quick_math/presentation/home/home_controller.dart';
import 'package:quick_math/presentation/themes/app_color.dart';
import 'package:quick_math/presentation/themes/app_text_style.dart';

import 'widget/row_user_score.dart';

class GameScreen extends StatefulWidget {
  const GameScreen(
      {Key? key, required this.gamePlay, required this.levelSelected})
      : super(key: key);
  final GamePlay gamePlay;
  final LevelModel levelSelected;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late Timer timer;
  late GameController gameController;
  late HomeController homeController;
  bool isCounterStart = true;
  bool isOver = false;
  bool isPause = false;
  int counter = 3;
  int randomOperator = 0;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..stop();
    homeController = Provider.of<HomeController>(context, listen: false);
    homeController.player.setAsset(MusicConstant.count);

    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {
          if (mounted && animation.value == 1.0) {
            isOver = true;
            animationController.stop();
            gameController.setUser();
            homeController.player.setAsset(MusicConstant.over);
            homeController.player.play();
            Future.delayed(const Duration(milliseconds: 1200), () {
              homeController.player.stop();
            });
          }
        });
      });
    homeController.player.play();
    if (mounted) {
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        setState(() {
          counter--;
          if (counter == 0) {
            homeController.player.stop();
            homeController.player.setAsset(MusicConstant.play);
            homeController.player.play();
            animationController.forward();
            isCounterStart = false;
            randomOperator = 1 + Random().nextInt(3);
            widget.gamePlay.play(randomOperator);
            widget.gamePlay.showOperator;
            counter = 0;
            timer.cancel();
          }
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameController = Provider.of<GameController>(context);
    gameController.score = 0;
    gameController.levelSelected = widget.levelSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              if (counter > 0 || isOver) {
                return;
              }
              setState(() {});
              isPause = true;
              homeController.player.pause();
              homeController.player.setAsset(MusicConstant.pause);
              homeController.player.play();
              Future.delayed(const Duration(milliseconds: 1200), () {
                homeController.player.stop();
              });
              animationController.stop();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.pause,
                color: AppColor.mainColor,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: isCounterStart
                ? const SizedBox()
                : Column(
                    children: [
                      ProgressBar(
                        valueAnimation: animation.value,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child:
                            RowUserScoreWidget(gameController: gameController),
                      ),
                      if (isOver)
                        Flexible(
                          child: Column(
                            children: [
                              const Spacer(),
                              GameOverWidget(
                                levelMode: widget.levelSelected.level ?? "",
                                score: gameController.score,
                                highScore:
                                    gameController.levelSelected.highScore,
                                onBack: () {
                                  homeController.player
                                      .setAsset(MusicConstant.bg);
                                  homeController.player.play();
                                  Navigator.pop(context);
                                },
                                onRefresh: () async {
                                  gameController.score = 0;
                                  setState(() {
                                    isOver = false;
                                    _reset();
                                  });
                                  homeController.player
                                      .setAsset(MusicConstant.play);
                                  homeController.player.play();
                                },
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                            ],
                          ),
                        ),
                      if (!isOver)
                        Expanded(
                            child: MainGameWidget(
                          showOperator: widget.gamePlay.showOperator,
                          onResult: (result) async {
                            setState(() {});
                            if (widget.gamePlay.result == result) {
                              gameController.score += 1;
                              _reset();
                            } else {
                              isOver = true;
                              homeController.player
                                  .setAsset(MusicConstant.over);
                              homeController.player.play();
                              Future.delayed(const Duration(milliseconds: 1200),
                                  () {
                                homeController.player.stop();
                              });
                              animationController.stop();
                              await gameController.setUser();
                            }
                          },
                          results: widget.gamePlay.results,
                        )),
                    ],
                  ),
          ),
          if (isCounterStart)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.4),
              alignment: Alignment.center,
              child: Text(
                '$counter',
                style: AppTextStyle.heading6.copyWith(fontSize: 30),
              ),
            ),
          if (isPause)
            PauseWidget(
              onContinue: () {
                setState(() {});
                animationController.forward();
                homeController.player.setAsset(MusicConstant.play);
                homeController.player.play();
                isPause = false;
              },
            )
        ],
      ),
    );
  }

  void _reset() {
    animationController.reset();
    randomOperator = 1 + Random().nextInt(3);
    widget.gamePlay.play(randomOperator,);
    widget.gamePlay.showOperator;
    animationController.forward();
  }
}
