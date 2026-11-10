import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../profile/screens/profile_screen.dart';
import 'home_screen.dart';
import 'saved_drinks_screen.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SavedDrinksScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            activeIcon: Icon(Icons.menu_book_rounded),
            label: l10n.recipesTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_rounded),
            activeIcon: Icon(Icons.bookmark_rounded),
            label: l10n.savedDrinksTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: l10n.accountTab,
          ),
        ],
      ),
    );
  }
}
