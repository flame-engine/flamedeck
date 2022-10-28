import 'package:flamedeck/widgets/widgets.dart';
import 'package:flamedeck_cartridge/flamedeck_cartridge.dart';
import 'package:flutter/material.dart';

class Cartridge extends StatelessWidget {
  const Cartridge({
    super.key,
    required this.cartridge,
    required this.width,
    required this.height,
  });

  final FlamedeckCartridge cartridge;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Panel(
      width: width,
      height: height,
      offset: height * .08,
      color: const Color(0xff2b2b2b),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height * .65,
              child: Container(
                color: const Color(0xff474747),
                padding: const EdgeInsets.all(8),
                child: Image.asset(cartridge.gameCover),
              ),
            ),
              Icon(Icons.arrow_drop_down_sharp, size: height * .2),
            Container(
              height: 8,
              width: width * .85,
              decoration: const BoxDecoration(
                color: Color(0xff474747),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(16),
                  topStart: Radius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
