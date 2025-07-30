import 'package:expenso/providers/screen_provider.dart';
import 'package:expenso/screens/dashboard_screen.dart';
import 'package:expenso/screens/expense_list_screen.dart';
import 'package:expenso/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const ExpensoApp()));
}

class ExpensoApp extends ConsumerWidget {
  const ExpensoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sp = ref.watch(screenProvider);
    final screens = [HomeScreen(), DashboardScreen()];
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
          selectedIndex: sp,
          onDestinationSelected: (val) =>
              ref.read(screenProvider.notifier).change(val),
        ),
        body: screens[sp],
      ),
      theme: ThemeData.dark(),
    );
  }
}
