import 'package:flutter/material.dart';

class CountingWidget extends StatelessWidget {
  final double progress;
  const CountingWidget({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Calculating data...',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${progress.toInt()}%',
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(
          height: 20,
        ),
        if (progress > 0)
          Container(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              value: progress / 100,
              color: Colors.blue,
            ),
          ),
      ],
    );
  }
}
