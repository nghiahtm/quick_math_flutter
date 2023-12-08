import 'package:flutter/material.dart';
import 'package:quick_math/presentation/themes/app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 55)),
          overlayColor:
              MaterialStateProperty.all(AppColor.mainColor.withOpacity(0.1)),
          backgroundColor: MaterialStateProperty.all(AppColor.white),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
              color: AppColor.mainColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ));
  }
}
