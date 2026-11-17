import 'package:flutter/material.dart';

class SuccessWidget extends StatelessWidget {
  final VoidCallback onPress;
  const SuccessWidget({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All calculations has finished, you can send your results to server and check results in a result tab',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '100%',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                value: 1,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPress,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text('Send result to server'),
          ),
        ),
      ],
    );
  }
}
