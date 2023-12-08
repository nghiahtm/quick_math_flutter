import 'package:flutter/cupertino.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Best score"),
        Text("Score"),
      ],
    );
  }
}
