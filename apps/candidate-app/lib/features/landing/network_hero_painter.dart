import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Paints concentric circles and a central network with optional animation [t] 0→1 (rings expand, center pulses).
class NetworkHeroPainter extends CustomPainter {
  NetworkHeroPainter({
    required this.primaryColor,
    this.dotCount = 14,
    this.t = 1.0,
    this.pulse = 0.0,
  });

  final Color primaryColor;
  final int dotCount;
  final double t;   // 0 = rings collapsed, 1 = full
  final double pulse; // 0..1 for center glow

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 * 0.88;

    // Concentric circles (ripple) – animated expansion
    for (var i = 4; i >= 1; i--) {
      final r = radius * (i / 4) * t;
      final opacity = (0.06 + (4 - i) * 0.05) * t;
      final paint = Paint()
        ..color = primaryColor.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(center, r, paint);
    }

    // Center glow when pulse > 0
    if (pulse > 0) {
      final glowPaint = Paint()
        ..color = primaryColor.withValues(alpha: 0.12 * pulse)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius * 0.5, glowPaint);
    }

    // Central network: 1 center + 4 nodes
    final nodeRadius = radius * 0.11;
    final outerNodeRadius = radius * 0.32 * t;
    final centerSize = nodeRadius * (1.6 + 0.2 * pulse);
    final centerPaint = Paint()..color = primaryColor;
    canvas.drawCircle(center, centerSize, centerPaint);

    for (var i = 0; i < 4; i++) {
      final angle = (i * math.pi / 2) + math.pi / 4;
      final nodeCenter = center + Offset(math.cos(angle) * outerNodeRadius, math.sin(angle) * outerNodeRadius);
      final nodePaint = Paint()..color = primaryColor;
      canvas.drawCircle(nodeCenter, nodeRadius, nodePaint);
      final linePaint = Paint()
        ..color = primaryColor.withValues(alpha: 0.45)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawLine(center, nodeCenter, linePaint);
    }

    // Scattered dots – slight fade in with t
    final random = math.Random(42);
    for (var i = 0; i < dotCount; i++) {
      final r = radius * (0.22 + random.nextDouble() * 0.7);
      final angle = random.nextDouble() * 2 * math.pi;
      final dotCenter = center + Offset(math.cos(angle) * r, math.sin(angle) * r);
      final dotRadius = 3.0 + random.nextDouble() * 4;
      final alpha = (0.15 + random.nextDouble() * 0.45) * t;
      final dotPaint = Paint()..color = primaryColor.withValues(alpha: alpha);
      canvas.drawCircle(dotCenter, dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant NetworkHeroPainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.pulse != pulse;
  }
}
