import 'package:flutter/material.dart';
import 'package:flutter_giphy_search/pages/gif_detail.dart';
import 'package:flutter_giphy_search/pages/home.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const Home()),
        GoRoute(
          path: '/gif',
          builder: (context, state) {
            final gif = state.extra as Map<dynamic, dynamic>?;

            if (gif == null) {
              return Scaffold(
                body: Center(child: Text('Objeto não fornecido')),
              );
            }
            return GifDetail(gif: gif);
          },
        ),
      ],
    );
  }
}
