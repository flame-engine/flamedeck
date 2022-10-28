import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  const Panel({
    super.key,
    this.child,
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.offset = 20,
    this.width,
    this.height,
  });

  final Widget? child;

  final Color color;
  final BorderRadius borderRadius;
  final double offset;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final paint = CustomPaint(
      painter: _Painter(
        borderRadius: borderRadius,
        color: color,
        offset: offset,
      ),
      child: child,
    );

    if (width == null && height == null) {
      return SizedBox.expand(child: paint);
    } else {
      return SizedBox(
        width: width,
        height: height,
        child: paint,
      );
    }
  }
}

class _Painter extends CustomPainter {
  _Painter({
    required this.borderRadius,
    required this.offset,
    required this.color,
  });

  final BorderRadius borderRadius;
  final double offset;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final shadowPaint = Paint()..color = color.darken(.4);

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final top = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    final bottom = RRect.fromRectAndCorners(
      rect.translate(0, offset),
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    canvas.drawRRect(bottom, shadowPaint);
    canvas.drawRRect(top, paint);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.color != color ||
        oldDelegate.offset != offset;
  }
}
