import 'package:flutter/cupertino.dart';
import 'package:quick_math/presentation/themes/app_button.dart';
import 'package:quick_math/presentation/themes/app_color.dart';

class MainGameWidget extends StatelessWidget {
  const MainGameWidget(
      {Key? key,
      required this.showOperator,
      required this.results,
      required this.onResult})
      : super(key: key);
  final String showOperator;
  final List<int> results;
  final Function(int) onResult;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Center(
              child: Text(
                showOperator,
                style: const TextStyle(
                    fontSize: 60,
                    color: AppColor.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: List.generate(
                  results.length,
                  (index) => Column(
                    children: [
                      AppButton(
                          title: '${results[index]}',
                          onPressed: () => onResult(results[index])),
                      const SizedBox(height: 16,)
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
