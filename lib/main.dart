import 'package:expenso/screens/navigate_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ExpensoApp());
}

class ExpensoApp extends StatefulWidget {
  const ExpensoApp({super.key});

  @override
  State<ExpensoApp> createState() => _ExpensoAppState();
}

class _ExpensoAppState extends State<ExpensoApp> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
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
      ),
      theme: ThemeData.dark(),
    );
  }
}
