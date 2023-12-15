import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_math/common/image_constant.dart';
import 'package:quick_math/presentation/app_controller.dart';
import 'package:quick_math/presentation/home/home_controller.dart';
import 'package:quick_math/presentation/routes/route_constant.dart';
import 'package:quick_math/presentation/themes/app_button.dart';
import 'package:quick_math/presentation/themes/app_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Image.asset(ImageConstant.imgApp),
            Flexible(
              child: Consumer<AppController>(builder: (_, app, child) {
                if (app.userModel == null ||
                    app.userModel!.name == null ||
                    app.userModel!.name!.isEmpty) {
                  return const SizedBox();
                }
                return Text(
                  "Chào mừng bạn ${app.userModel?.name ?? ""} đã trở lại",
                  style: const TextStyle(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                );
              }),
            ),
            Flexible(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                      title: "Chơi",
                      onPressed: () {
                        Navigator.pushNamed(context, RouteConstant.level);
                      }),
                Consumer<AppController>(builder: (_, app, child) {
                  if (app.userModel == null ||
                      app.userModel!.name == null ||
                      app.userModel!.name!.isEmpty) {
                    return const SizedBox();
                  }
                  return AppButton(title: "Thành tích", onPressed: () {
                    Navigator.pushNamed(context, RouteConstant.achievement);
                  });
                }),
                  AppButton(title: "Bảng xếp hạng", onPressed: () {
                    Navigator.pushNamed(context, RouteConstant.leader);
                  }),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<HomeController>().setPlayMusic();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(40, 40)),
                overlayColor: MaterialStateProperty.all(
                    AppColor.mainColor.withOpacity(0.1)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                backgroundColor: MaterialStateProperty.all(AppColor.white),
              ),
              icon: Icon(
                context.watch<HomeController>().isPlayMusic
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
                color: AppColor.mainColor,
                size: 30,
              ),
            ),
            const Spacer(),
            const SafeArea(
              child: Text(
                "Sản phẩm bởi Nghĩa D02k14",
                style: TextStyle(
                    color: AppColor.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
