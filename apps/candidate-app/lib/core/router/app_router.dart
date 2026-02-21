import 'package:flutter/material.dart';

import '../../features/placeholder_screen.dart';

final appRouter = RouterConfiguration(
  initialRoute: '/',
  routes: {
    '/': (context) => const PlaceholderScreen(),
  },
);

class RouterConfiguration {
  RouterConfiguration({
    required this.initialRoute,
    required this.routes,
  });

  final String initialRoute;
  final Map<String, Widget Function(BuildContext)> routes;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: builder,
      );
    }
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (context) => Scaffold(
        body: Center(child: Text('Not found: ${settings.name}')),
      ),
    );
  }
}
