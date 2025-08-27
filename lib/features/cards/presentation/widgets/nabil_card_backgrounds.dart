// lib/features/cards/presentation/widgets/nabil_card_backgrounds.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
class GeometricBackground extends StatelessWidget {
  final Color color;
  final double opacity;

  const GeometricBackground({
    super.key,
    required this.color,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: GeometricPainter(
        color: color.withValues(alpha: opacity),
      ),
    );
  }
}

class GeometricPainter extends CustomPainter {
  final Color color;

  GeometricPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw geometric pattern
    _drawTriangularPattern(canvas, size, paint);
    // _drawCircularElements(canvas, size, paint);
  }

  void _drawTriangularPattern(Canvas canvas, Size size, Paint paint) {
    const int rows = 8;
    const int cols = 12;
    
    final double triangleHeight = size.height / rows;
    final double triangleWidth = size.width / cols;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final double x = col * triangleWidth;
        final double y = row * triangleHeight;
        
        if ((row + col) % 3 == 0) {
          _drawTriangle(canvas, Offset(x, y), triangleWidth, triangleHeight, paint);
        }
      }
    }
  }

  void _drawTriangle(Canvas canvas, Offset position, double width, double height, Paint paint) {
    final path = Path();
    path.moveTo(position.dx + width / 2, position.dy);
    path.lineTo(position.dx, position.dy + height);
    path.lineTo(position.dx + width, position.dy + height);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  // void _drawCircularElements(Canvas canvas, Size size, Paint paint) {
  //   final glowPaint = Paint()
  //     // ignore: deprecated_member_use
  //     ..color = color.withValues(alpha: color.alpha * 0.5)
  //     ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

  //   // // Draw some glowing circles
  //   // canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 20, glowPaint);
  //   // canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.6), 15, glowPaint);
  //   // canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 25, glowPaint);
  // }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ContactlessWaves extends StatelessWidget {
  final Color color;
  final double size;

  const ContactlessWaves({
    super.key,
    required this.color,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: ContactlessWavesPainter(color: color),
    );
  }
}

class ContactlessWavesPainter extends CustomPainter {
  final Color color;

  ContactlessWavesPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw concentric arcs for contactless symbol
    for (int i = 1; i <= 3; i++) {
      final radius = (size.width / 6) * i;
      canvas.drawArc(
        Rect.fromCenter(center: center, width: radius * 2, height: radius * 2),
        -math.pi / 3,
        2 * math.pi / 3,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}