import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_hive/presentation/view/screen/chat/chat_screen.dart';
import 'package:todo_hive/presentation/view/screen/movie/movie_screen.dart';
import 'package:todo_hive/presentation/view/screen/task/home/home_screen.dart';
import 'package:todo_hive/presentation/view/widget/navigation/bottom_navigation_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key, required this.tab}) : super(key: key);

  static const String routeName = "mainNavigation";

  final String tab;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "movie",
    "chat",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const MovieScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const ChatScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 12, top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              text: "Home",
              isSelected: _selectedIndex == 0,
              icon: Icons.task,
              onTap: () => _onTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: "Movie",
              isSelected: _selectedIndex == 1,
              icon: Icons.local_movies_rounded,
              onTap: () => _onTap(1),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: "Chat",
              isSelected: _selectedIndex == 2,
              icon: Icons.chat,
              onTap: () => _onTap(2),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
