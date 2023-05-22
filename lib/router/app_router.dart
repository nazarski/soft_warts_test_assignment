import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soft_warts_test_task/pages/home_page/home_page.dart';
import 'package:soft_warts_test_task/pages/todo_list_page/todo_list_page.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    log('⤴️ ${settings.name}');
    switch (settings.name) {
      case HomePage.routeName:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
        );
      case TodoListPage.routeName:
        return PageTransition(
          child: const TodoListPage(),
          type: PageTransitionType.fade,
        );
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}