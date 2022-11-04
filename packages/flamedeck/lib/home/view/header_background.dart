import 'dart:math' as math;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: .8,
                colors: [
                  Colors.yellowAccent,
                  Colors.orangeAccent,
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: ClipRect(
            child: GameWidget(game: _BackgroundGame()),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class Screen {
  late final double x;
  late final double y;
  late final double width;
  late final double scale;
}

class Camera {
  late final double x;
  late final double y;
  late final double z;
}

class RoadSegmentPoint {
  RoadSegmentPoint(
    this.worldX,
    this.worldY,
    this.worldZ,
    this.screen,
    this.camera,
  );

  double worldX;
  double worldY;
  double worldZ;
  Screen screen;
  Camera camera;
}

class RoadSegment {
  RoadSegment(
    this.index,
    this.p1,
    this.p2, {
    required this.light,
  });

  int index;
  bool light;
  RoadSegmentPoint p1;
  RoadSegmentPoint p2;
}

class _BackgroundGame extends Game {
  static final darkRoadSegmentPaint = Paint()..color = const Color(0xFFD52D5C);

  static final lightRoadSegmentPaint = Paint()..color = const Color(0xFFBD1F90);

  static double segmentLength = 150;
  static int fieldOfView = 100;
  static double cameraHeight = 500;
  static double cameraDepth = 1 / math.tan((fieldOfView / 2) * math.pi / 180);
  static double maxSpeed = segmentLength / 16;

  late List<RoadSegment> segments;
  double roadWidth = 1800;
  int rumbleLength = 3;
  late double trackLength;
  int lanes = 3;
  int drawDistance = 300;

  double playerX = 0;

  int fogDensity = 5;
  double position = 10;
  int speed = 4000;
  double accel = maxSpeed / 5;
  double breaking = -maxSpeed;
  double decel = -maxSpeed / 5;
  double offRoadDecel = -maxSpeed / 2;
  double offRoadLimit = maxSpeed / 4;

  void resetRoad() {
    segments = List.generate(300, (n) {
      return RoadSegment(
        n,
        RoadSegmentPoint(0, 0, n * segmentLength, Screen(), Camera()),
        RoadSegmentPoint(0, 0, (n + 1) * segmentLength, Screen(), Camera()),
        light: (n / rumbleLength).floor().isEven,
      );
    });

    trackLength = segments.length * segmentLength;
  }

  RoadSegment findSegment(int z) {
    return segments[((z / segmentLength) % segments.length).floor()];
  }

  void projectRoadSegmentPoint(
    RoadSegmentPoint p,
    double cameraX,
    double cameraY,
    double cameraZ,
    double cameraDepth,
    double width,
    double height,
    double roadWidth,
  ) {
    p.camera.x = p.worldX - cameraX;
    p.camera.y = p.worldY - cameraY;
    p.camera.z = p.worldZ - cameraZ;
    p.screen.scale = cameraDepth / p.camera.z;
    p.screen.x = ((width / 2) + (p.screen.scale * p.camera.x * width / 2))
        .round()
        .toDouble();
    p.screen.y = ((height / 2) - (p.screen.scale * p.camera.y * height / 2))
        .round()
        .toDouble();
    p.screen.width =
        (p.screen.scale * roadWidth * width / 2).round().toDouble();
  }

  void renderRoad(Canvas canvas) {
    final baseSegment = findSegment(0);
    final maxY = size.y;

    int n;
    RoadSegment segment;

    for (n = 0; n < drawDistance; n++) {
      segment = segments[(baseSegment.index + n) % segments.length];

      projectRoadSegmentPoint(
        segment.p1,
        playerX * roadWidth,
        cameraHeight,
        position,
        cameraDepth,
        size.x,
        size.y,
        roadWidth,
      );

      projectRoadSegmentPoint(
        segment.p2,
        playerX * roadWidth,
        cameraHeight,
        position,
        cameraDepth,
        size.x,
        size.y,
        roadWidth,
      );

      if ((segment.p1.camera.z <= cameraDepth) || // behind us
          (segment.p2.screen.y >= maxY)) {
        continue;
      }

      renderSegment(
        canvas,
        size.x,
        lanes,
        segment.p1.screen.x,
        segment.p1.screen.y,
        segment.p1.screen.width,
        segment.p2.screen.x,
        segment.p2.screen.y,
        segment.p2.screen.width,
        segment.light ? lightRoadSegmentPaint : darkRoadSegmentPaint,
      );
    }
  }

  void polygon(
    Canvas c,
    double x1,
    double y1,
    double x2,
    double y2,
    double x3,
    double y3,
    double x4,
    double y4,
    Paint color,
  ) {
    final path = Path()
      ..moveTo(x1, y1)
      ..lineTo(x2, y2)
      ..lineTo(x3, y3)
      ..lineTo(x4, y4)
      ..close();

    c.drawPath(path, color);
  }

  void renderSegment(
    Canvas c,
    double width,
    int lanes,
    double x1,
    double y1,
    double w1,
    double x2,
    double y2,
    double w2,
    Paint paint,
  ) {
    polygon(c, x1 - w1, y1, x1 + w1, y1, x2 + w2, y2, x2 - w2, y2, paint);
  }

  @override
  Future<void> onLoad() async {
    resetRoad();
  }

  @override
  void render(Canvas canvas) {
    renderRoad(canvas);
  }

  double increase(double start, double increment, double max) {
    var result = start + increment;
    while (result >= max) {
      result -= max;
    }
    while (result < 0) {
      result += max;
    }
    return result;
  }

  @override
  void update(double dt) {
    position = increase(position, dt * speed, trackLength);
  }

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }
}
