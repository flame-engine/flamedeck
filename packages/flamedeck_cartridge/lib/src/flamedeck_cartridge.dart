import 'package:flutter/material.dart';

/// {@template flamedeck_cartridge}
/// Package with the definition on how to implement a FlameDeck cartridge
/// {@endtemplate}
class FlamedeckCartridge {
  /// {@macro flamedeck_cartridge}
  const FlamedeckCartridge({
    required this.cartridgeBuilder,
    required this.title,
    required this.description,
    required this.author,
    required this.authorLink,
    required this.gameCover,
  });

  /// A [WidgetBuilder] that will build the game cartridge.
  final WidgetBuilder cartridgeBuilder;

  /// Game title.
  final String title;

  /// Game description.
  final String description;

  /// Author of the name.
  final String author;

  /// Linkback to the author.
  final String authorLink;

  /// Image path for the cartridge cover.
  final String gameCover;
}
