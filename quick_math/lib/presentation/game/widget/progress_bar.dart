import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_math/presentation/themes/app_color.dart';

class ProgressBar extends StatelessWidget{
  const ProgressBar({super.key, required this.valueAnimation});

  final double valueAnimation;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
      color: AppColor.white,
      child: Stack(
        children: [
          LayoutBuilder(builder: (_, constraints) {
            return Container(
              width: constraints.maxWidth * valueAnimation,
              color: AppColor.amber,
            );
          })
        ],
      ),
    );
  }
}
