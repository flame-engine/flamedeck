import 'package:flamedeck/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Shell extends StatelessWidget {
  const Shell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppCubit>().state;

    return Container(
      padding: const EdgeInsets.all(16),
      color: appState.shellColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  color: Color(0xff1a1a1a),
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    Expanded(child: child),
                    const SizedBox(
                      height: 32,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        child: Text('FlameDeck'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
