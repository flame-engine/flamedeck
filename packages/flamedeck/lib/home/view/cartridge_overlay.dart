import 'package:flamedeck/home/home.dart';
import 'package:flamedeck_cartridge/flamedeck_cartridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartridgeOverlay extends StatefulWidget {
  const CartridgeOverlay({
    super.key,
    required this.cartridge,
  });

  final FlamedeckCartridge cartridge;

  static Future<void> show(
    BuildContext context,
    FlamedeckCartridge cartridge,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (_) => CartridgeOverlay(
        cartridge: cartridge,
      ),
    );
  }

  @override
  State<CartridgeOverlay> createState() => _CartridgeOverlayState();
}

class _CartridgeOverlayState extends State<CartridgeOverlay> {
  bool _show = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
        () {
          _show = true;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: _show ? 32 : - mediaQuery.size.height,
          child: Cartridge(
            cartridge: widget.cartridge,
            width: mediaQuery.size.width * .4,
            height: mediaQuery.size.width * .4,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: _show ? 32 : - mediaQuery.size.height,
          child: Console(
            cartridge: widget.cartridge,
            width: mediaQuery.size.width * .6,
            height: mediaQuery.size.width,
          ),
        ),
      ],
    );
  }
}
