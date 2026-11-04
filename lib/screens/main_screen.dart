
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'explore_screen.dart';
import 'diary_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  // Daftar halaman utama aplikasi
  final List<Widget> screens = const [
    HomeScreen(),
    ExploreScreen(),
    DiaryScreen(),
    ProfileScreen(),
  ];

  // Daftar tujuan navigasi
  final List<NavigationDestination> destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.explore_outlined),
      selectedIcon: Icon(Icons.explore_rounded),
      label: 'Explore',
    ),
    NavigationDestination(
      icon: Icon(Icons.library_music_outlined),
      selectedIcon: Icon(Icons.library_music_rounded),
      label: 'My Diary',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Profile',
    ),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 840;

        if (isWide) {
          // Navigasi untuk layar lebar
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: const Color(0xFF211C2B),
                  indicatorColor: const Color(0xFF9B7EDE).withValues(
                    alpha: 0.25,
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded),
                      label: Text('Explore'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.library_music_outlined),
                      selectedIcon: Icon(Icons.library_music_rounded),
                      label: Text('My Diary'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person_rounded),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Color(0xFF302A3A),
                ),
                Expanded(
                  child: IndexedStack(
                    index: selectedIndex,
                    children: screens,
                  ),
                ),
              ],
            ),
          );
        }

        // Navigasi untuk layar compact
        return Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            backgroundColor: const Color(0xFF211C2B),
            indicatorColor: const Color(0xFF9B7EDE).withValues(
              alpha: 0.25,
            ),
            destinations: destinations,
          ),
        );
      },
    );
  }
}
