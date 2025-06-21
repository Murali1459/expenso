import 'package:expenso/screens/navigate_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(CupertinoIcons.home), label: "Home"),
          NavigationDestination(
            icon: Icon(CupertinoIcons.graph_square_fill),
            label: "Dashboard",
          ),
        ],
        selectedIndex: screenIndex,
        onDestinationSelected: (val) {
          setState(() {
            screenIndex = val;
          });
        },
      ),
      body: NavigateScreen(index: screenIndex),
    );
  }
}
