import 'dart:async';

import 'package:pathfinder/screens/home_screen/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/screens/home_screen/widgets/counting_widget.dart';
import 'package:pathfinder/screens/home_screen/widgets/success_widget.dart';
import 'package:pathfinder/screens/home_screen/widgets/url_widget.dart';

import 'widgets/error_widget.dart';

final URLRegexp =
    RegExp(r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+~#?&//=]*)');

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  StreamSubscription<ScreenState>? _sub;
  final _bloc = HomeScreenBloc();

  @override
  void initState() {
    _sub = _bloc.screenStateStream.listen((state) {
      if (state.type == ScreenStateEnum.start) {
        _controller.text = state.url;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Colors.blueAccent,
        title: Container(
          child: Text(
            'Home Screen',
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: StreamBuilder<ScreenState>(
            stream: _bloc.screenStateStream,
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) return Container();

              switch (data.type) {
                case ScreenStateEnum.start:
                  return UrlWidget(
                    isLoading: _bloc.loadingStream,
                    controller: _controller,
                    onPress: () => _bloc.startCounting(_controller.text),
                  );
                case ScreenStateEnum.counting:
                  return CountingWidget(progress: data.progress);
                case ScreenStateEnum.success:
                  return SuccessWidget(
                    isLoading: _bloc.loadingStream,
                    onPress: () => _bloc.sendResult(),
                  );
                case ScreenStateEnum.error:
                  return ErrorTextWidget(
                    errorText: data.error,
                    onPress: () => _bloc.resetScreen(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    _sub?.cancel();
    super.dispose();
  }
}
