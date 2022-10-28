import 'package:flamedeck/cartridges/dash_vikings/dash_vikings.dart';
import 'package:flamedeck_cartridge/flamedeck_cartridge.dart';

final dashVikingsCartridge = FlamedeckCartridge(
  cartridgeBuilder: (_) => const DashingVikings(),
  title: 'Dashing Vikings',
  description: 
'''
Yet another clone of the classic Chrome's Dino Run game.
But this time with a twist, instead of Dino, you play with Dash, and instead of
just avoiding trees, you can gather gear and destroy them!

Made as a showcase game for the 2022 Flutter Vikings event.
''',
  author: 'Erick Zanardo',
  authorLink: 'https://twitter.com/CptPixel',
  gameCover: 'assets/cartridges/dash_viking/cover.png',
);
