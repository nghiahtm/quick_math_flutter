import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_math/common/enums/state_enum.dart';
import 'package:quick_math/presentation/archivement/achievement_controller.dart';
import 'package:quick_math/presentation/themes/app_color.dart';
import 'package:quick_math/presentation/themes/app_text_style.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  void initState() {
    Provider.of<AchievementController>(context, listen: false).initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Thành tích",
          style: AppTextStyle.heading1,
        ),
        centerTitle: true,
      ),
      body: Consumer<AchievementController>(
          builder: (context, controller, child) {
        if (controller.state == StateEnum.loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColor.white,
            strokeWidth: 6,
          ));
        }
        return Column(
          children: [
            const Spacer(),
            Text("Cấp độ",style: AppTextStyle.heading6,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(controller.levelUser.length, (index) {
                final level = controller.levelUser[index];
                String infor = "${level.level}: ${level.highScore}";
                return Center(
                    child: Text(
                  infor,
                  style: AppTextStyle.heading1,
                ));
              }),
            ),
            const Spacer(flex: 2,)
          ],
        );
      }),
    );
  }
}
