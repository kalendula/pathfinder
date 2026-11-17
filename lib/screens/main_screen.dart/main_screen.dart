import 'package:flutter/material.dart';
import 'package:pathfinder/screens/home_screen/home_screen.dart';
import 'package:pathfinder/screens/result_screen/result_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.check_box_sharp), label: 'Results'),
        ],
        onTap: (page) {
          setState(() {
            _selectedIndex = page;
          });
          _controller.jumpToPage(page);
        },
        selectedItemColor: Colors.orange,
        currentIndex: _selectedIndex,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _controller,
        children: [
          HomePage(),
          ResultScreen(),
        ],
      ),
    );
  }
}
