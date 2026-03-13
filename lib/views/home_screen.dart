import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/main_viewmodel.dart';
import '../viewmodels/films_viewmodel.dart';
import 'films_list_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, mainViewModel, _) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.02, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: _buildCurrentScreen(mainViewModel.currentTab),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context, mainViewModel),
        );
      },
    );
  }

  Widget _buildCurrentScreen(MainTab tab) {
    switch (tab) {
      case MainTab.films:
        return const FilmsListScreen(key: ValueKey('films'));
      case MainTab.profile:
        return const ProfileScreen(key: ValueKey('profile'));
      case MainTab.settings:
        return const SettingsScreen(key: ValueKey('settings'));
    }
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    MainViewModel viewModel,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(
          top: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                MainTab.films,
                Icons.movie_outlined,
                Icons.movie,
                'Films',
                viewModel,
              ),
              _buildNavItem(
                context,
                MainTab.profile,
                Icons.person_outline,
                Icons.person,
                'Profile',
                viewModel,
              ),
              _buildNavItem(
                context,
                MainTab.settings,
                Icons.settings_outlined,
                Icons.settings,
                'Settings',
                viewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    MainTab tab,
    IconData outlinedIcon,
    IconData filledIcon,
    String label,
    MainViewModel viewModel,
  ) {
    final isSelected = viewModel.currentTab == tab;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => viewModel.setTab(tab),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isSelected ? filledIcon : outlinedIcon,
                key: ValueKey(isSelected),
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : Colors.grey[400],
                size: 24,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              AnimatedOpacity(
                opacity: isSelected ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  label,
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
