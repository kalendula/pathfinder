import 'package:pathfinder/app.dart';
import 'package:pathfinder/injector/injector.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.register();
  runApp(App());
}
