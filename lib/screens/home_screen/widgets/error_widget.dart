import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String errorText;
  final VoidCallback onPress;
  const ErrorTextWidget({Key? key, required this.errorText, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorText,
          style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPress,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text('Try again'),
          ),
        ),
      ],
    );
  }
}
