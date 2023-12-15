import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_math/common/enums/level_enum.dart';
import 'package:quick_math/models/achievement_model.dart';
import 'package:quick_math/presentation/leader_board/leader_board_controller.dart';
import 'package:quick_math/presentation/themes/app_color.dart';
import 'package:quick_math/presentation/themes/app_text_style.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Bảng xếp hạng",
            style: AppTextStyle.heading1,
          ),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColor.white,
            dividerColor: AppColor.mainColor,
            tabs: <Widget>[
              Tab(
                child: Text(
                  LevelEnum.easy,
                  style: AppTextStyle.heading6,
                ),
              ),
              Tab(
                child: Text(
                  LevelEnum.normal,
                  style: AppTextStyle.heading6,
                ),
              ),
              Tab(
                child: Text(
                  LevelEnum.hard,
                  style: AppTextStyle.heading6,
                ),
              ),
              Tab(
                child: Text(
                  LevelEnum.threeOperatorMode,
                  style: AppTextStyle.heading6,
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: context.read<LeaderboardController>().initState(),
            builder: (context, snapshot) {
              return TabBarView(
                children: List.generate(
                  4,
                  (index) {
                    return Builder(builder: (context) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColor.white,
                          strokeWidth: 5,
                        ));
                      }
                      final listLevel =
                          context.read<LeaderboardController>().leader;
                      List<InformationUserScore> scoreLevel = listLevel.easy;
                      if (index == 1) {
                        scoreLevel = listLevel.normal;
                      } else if (index == 2) {
                        scoreLevel = listLevel.hard;
                      }else if (index == 3) {
                        scoreLevel = listLevel.threeOperator;
                      }
                      return ListView.builder(
                        itemBuilder: (_, indexLevel) {
                          return ListTile(
                            tileColor:
                                (context.read<LeaderboardController>().idUser !=
                                            null &&
                                        context
                                                .read<LeaderboardController>()
                                                .idUser ==
                                            scoreLevel[indexLevel].idUser)
                                    ? AppColor.white.withOpacity(0.3)
                                    : Colors.transparent,
                            leading: Text(
                              "${indexLevel + 1}",
                              style: AppTextStyle.heading6,
                            ),
                            title: Text(
                              scoreLevel[indexLevel].name ?? "",
                              style: AppTextStyle.heading6,
                            ),
                            trailing: Text(
                              "${scoreLevel[indexLevel].highScore}",
                              style: AppTextStyle.heading6,
                            ),
                          );
                        },
                        itemCount: scoreLevel.length,
                      );
                    });
                  },
                ),
              );
            }),
      ),
    );
  }
}
