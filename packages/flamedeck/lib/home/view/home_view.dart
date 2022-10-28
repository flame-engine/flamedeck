import 'package:flamedeck/cartridges/cartridges.dart';
import 'package:flamedeck/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(32),
                      height: 200,
                      width: 200,
                      color: Colors.redAccent,
                    ),
                    Center(
                      child: Wrap(
                        children: [
                          for (int i = 0; i < cartridges.length; i++)
                            InkWell(
                              onTap: () async {
                                //context.read<HomeCubit>().selectGame(i);
                                await CartridgeOverlay.show(
                                  context,
                                  cartridges[i],
                                );
                              },
                              child: CartridgeCard(
                                cartridge: cartridges[i],
                              ),
                            ),
                        ],
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
