import 'package:flutter/material.dart';
import 'package:pathfinder/screens/result_item_screen/result_item_screen.dart';
import 'package:pathfinder/screens/result_screen/result_screen_bloc.dart';
import 'package:pathfinder/services/results_service.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _bloc = ResultScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Colors.blueAccent,
        title: Container(
          child: Text(
            'Result list screen',
          ),
        ),
      ),
      body: StreamBuilder<List<Result>>(
        stream: _bloc.resultsStream,
        builder: (context, snapshot) {
          final res = snapshot.data;
          if (res == null) return Container();
          if (res.isEmpty) return Center(child: Text('Nothing to see here for now'));
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: res.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultItemScreen(result: res[index]),
                    ),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                  child: Text(
                    res[index].stringPath,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
