import 'package:flamedeck_cartridge/flamedeck_cartridge.dart';
import 'package:flutter/material.dart';

class CartridgeCard extends StatelessWidget {
  const CartridgeCard({
    super.key,
    required this.cartridge,
  });

  final FlamedeckCartridge cartridge;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      width: 120,
      height: 120,
      child: Image.asset(cartridge.gameCover),
    );
  }
}
