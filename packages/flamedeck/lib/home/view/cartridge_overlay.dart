import 'package:flamedeck/game/game.dart';
import 'package:flamedeck/home/home.dart';
import 'package:flamedeck/widgets/widgets.dart';
import 'package:flamedeck_cartridge/flamedeck_cartridge.dart';
import 'package:flutter/material.dart';

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
  bool _load = false;
  bool _launchGame = false;

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

    late final double cartridgeTop;

    if (_show) {
      cartridgeTop = 32;
    } else {
      cartridgeTop = -mediaQuery.size.height;
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: cartridgeTop,
          child: AnimatedSlide(
            offset: _load ? const Offset(0, 3) : Offset.zero,
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticIn,
            onEnd: () {
              setState(() => _launchGame = true);
            },
            child: Cartridge(
              cartridge: widget.cartridge,
              width: mediaQuery.size.width * .4,
              height: mediaQuery.size.width * .4,
            ),
          ),
        ),
        Positioned(
          top: mediaQuery.size.width * .6,
          child: AnimatedOpacity(
            opacity: _load ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            child: AnimatedScale(
              scale: _show ? 1 : 20,
              duration: const Duration(milliseconds: 250),
              child: GestureDetector(
                onTap: () {
                  setState(() => _load = true);
                },
                child: const Panel(
                  width: 200,
                  height: 50,
                  offset: 10,
                  color: Colors.indigo,
                  child: Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text('Load it up!'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: _show ? 32 : -mediaQuery.size.height,
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 950),
            curve: Curves.easeIn,
            turns: _launchGame ? 10 : 0,
            child: AnimatedScale(
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              scale: _launchGame ? 20 : 1,
              onEnd: () {
                Navigator.of(context).pushReplacement(
                  GamePage.route(),
                );
              },
              child: Console(
                cartridge: widget.cartridge,
                width: mediaQuery.size.width * .6,
                height: mediaQuery.size.width,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
