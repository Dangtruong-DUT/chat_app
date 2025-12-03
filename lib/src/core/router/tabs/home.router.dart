import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/home/presentation/pages/chats/index.dart';
import 'package:chat_app/src/features/home/presentation/pages/search/index.dart';
import 'package:chat_app/src/features/home/presentation/pages/settings/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './tab.model.dart';

class HomeRouter {
  HomeRouter._();

  static const List<TabModel> _homeTabs = [
    TabModel(label: 'Chats', icon: Icons.chat, route: AppRoutesConfig.chats),
    TabModel(
      label: 'Search',
      icon: Icons.search,
      route: AppRoutesConfig.search,
    ),
    TabModel(
      label: 'Settings',
      icon: Icons.settings,
      route: AppRoutesConfig.settings,
    ),
  ];

  static final routes = ShellRoute(
    builder: _buildShell,
    routes: [
      GoRoute(
        path: AppRoutesConfig.chats,
        builder: (_, __) => const ChatListScreen(),
      ),
      GoRoute(
        path: AppRoutesConfig.chats,
        builder: (_, __) => const ChatListScreen(),
      ),
      GoRoute(
        path: AppRoutesConfig.search,
        builder: (_, __) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutesConfig.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
    ],
  );

  static Widget _buildShell(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getTabIndexByRoute(state.fullPath!),
        onTap: (index) => context.go(_homeTabs[index].route),
        items: _homeTabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }

  static int _getTabIndexByRoute(String location) {
    for (int i = 0; i < _homeTabs.length; i++) {
      if (location.startsWith(_homeTabs[i].route)) return i;
    }
    return 0;
  }
}
