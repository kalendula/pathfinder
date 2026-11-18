import 'package:flutter/material.dart';

class SuccessWidget extends StatelessWidget {
  final Stream<bool> isLoading;
  final VoidCallback onPress;
  const SuccessWidget({Key? key, required this.onPress, required this.isLoading}) : super(key: key);

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
        StreamBuilder<bool>(
          stream: isLoading,
          builder: (context, snapshot) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: snapshot.data ?? false ? null : onPress,
            child: snapshot.data ?? false
                ? Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text('Send result to server'),
                  ),
          ),
        ),
      ],
    );
  }
}
