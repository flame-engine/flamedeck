import 'package:flamedeck/game/game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static Route<void> route() => PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => const GamePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return const GameView();
  }
}
