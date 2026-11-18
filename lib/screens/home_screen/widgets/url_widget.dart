import 'package:flutter/material.dart';

class UrlWidget extends StatelessWidget {
  final Stream<bool> isLoading;
  final TextEditingController controller;
  final VoidCallback onPress;
  const UrlWidget({Key? key, required this.controller, required this.onPress, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Set valid API URL in order to continue',
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.wrap_text),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),
              maxLines: 1,
            ),
          ],
        ),
        StreamBuilder<bool>(
          stream: isLoading,
          builder: (context, snapshot) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.blue,
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
                    child: Text('Start counting process'),
                  ),
          ),
        ),
      ],
    );
  }
}
