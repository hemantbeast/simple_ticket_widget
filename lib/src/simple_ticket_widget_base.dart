import 'dart:math';

import 'package:flutter/material.dart';

class SimpleTicketWidget extends StatelessWidget {
  const SimpleTicketWidget({
    required this.child,
    super.key,
    this.arcRadius = 16,
    this.position = 100,
    this.blurRadius = 4,
    this.borderRadius = BorderRadius.zero,
    this.shadowColor = Colors.black54,
    this.direction = Axis.vertical,
  });

  final double position;

  final double arcRadius;

  final double blurRadius;

  final BorderRadius borderRadius;

  final Color shadowColor;

  final Axis direction;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _TicketShadowPainter(
              bottomHeight: position,
              holeRadius: arcRadius,
              bottomLeftRadius: borderRadius.bottomLeft.x,
              bottomRightRadius: borderRadius.bottomRight.x,
              topLeftRadius: borderRadius.topLeft.x,
              topRightRadius: borderRadius.topRight.x,
              shadowColor: shadowColor,
              blurSigma: blurRadius,
              direction: direction,
            ),
          ),
        ),
        ClipPath(
          clipper: _TicketClipper(
            bottomHeight: position,
            holeRadius: arcRadius,
            bottomLeftRadius: borderRadius.bottomLeft.x,
            bottomRightRadius: borderRadius.bottomRight.x,
            topLeftRadius: borderRadius.topLeft.x,
            topRightRadius: borderRadius.topRight.x,
            direction: direction,
          ),
          child: child,
        ),
      ],
    );
  }
}

class _TicketShadowPainter extends CustomPainter {
  final double holeRadius;
  final double bottomHeight;

  final double topLeftRadius;
  final double topRightRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;

  final double blurSigma;
  final Color shadowColor;
  final Axis direction;

  _TicketShadowPainter({
    required this.holeRadius,
    required this.bottomHeight,
    required this.topLeftRadius,
    required this.topRightRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.blurSigma,
    required this.shadowColor,
    required this.direction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);

    Path path;
    if (direction == Axis.vertical) {
      path = _getVerticalPath(
        size: size,
        holeRadius: holeRadius,
        position: bottomHeight,
        topLeftRadius: topLeftRadius,
        topRightRadius: topRightRadius,
        bottomRightRadius: bottomRightRadius,
        bottomLeftRadius: bottomLeftRadius,
      );
    } else {
      path = _getHorizontalPath(
        size: size,
        holeRadius: holeRadius,
        position: bottomHeight,
        topLeftRadius: topLeftRadius,
        topRightRadius: topRightRadius,
        bottomRightRadius: bottomRightRadius,
        bottomLeftRadius: bottomLeftRadius,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TicketShadowPainter oldDelegate) {
    return holeRadius != oldDelegate.holeRadius ||
        bottomHeight != oldDelegate.bottomHeight ||
        topLeftRadius != oldDelegate.topLeftRadius ||
        topRightRadius != oldDelegate.topRightRadius ||
        bottomRightRadius != oldDelegate.bottomRightRadius ||
        bottomLeftRadius != oldDelegate.bottomLeftRadius ||
        direction != oldDelegate.direction;
  }
}

class _TicketClipper extends CustomClipper<Path> {
  final double holeRadius;
  final double bottomHeight;
  final Axis direction;

  final double topLeftRadius;
  final double topRightRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;

  _TicketClipper({
    required this.holeRadius,
    required this.bottomHeight,
    required this.topLeftRadius,
    required this.topRightRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.direction,
  });

  @override
  Path getClip(Size size) {
    Path path;

    if (direction == Axis.vertical) {
      path = _getVerticalPath(
        size: size,
        holeRadius: holeRadius,
        position: bottomHeight,
        topLeftRadius: topLeftRadius,
        topRightRadius: topRightRadius,
        bottomRightRadius: bottomRightRadius,
        bottomLeftRadius: bottomLeftRadius,
      );
    } else {
      path = _getHorizontalPath(
        size: size,
        holeRadius: holeRadius,
        position: bottomHeight,
        topLeftRadius: topLeftRadius,
        topRightRadius: topRightRadius,
        bottomRightRadius: bottomRightRadius,
        bottomLeftRadius: bottomLeftRadius,
      );
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TicketClipper oldClipper) {
    return holeRadius != oldClipper.holeRadius ||
        bottomHeight != oldClipper.bottomHeight ||
        topLeftRadius != oldClipper.topLeftRadius ||
        topRightRadius != oldClipper.topRightRadius ||
        bottomRightRadius != oldClipper.bottomRightRadius ||
        bottomLeftRadius != oldClipper.bottomLeftRadius ||
        direction != oldClipper.direction;
  }
}

Path _getVerticalPath({
  required Size size,
  required double holeRadius,
  required double position,
  required double topLeftRadius,
  required double topRightRadius,
  required double bottomRightRadius,
  required double bottomLeftRadius,
}) {
  final radius = max(topLeftRadius, topRightRadius) +
      max(bottomLeftRadius, bottomRightRadius);
  position = position.clamp(radius * 2, size.height - radius);

  // Fix position to start from top.
  position = size.height - position;

  final path = Path()
    // Top-left corner radius
    ..moveTo(0, topLeftRadius)
    ..arcToPoint(
      Offset(topLeftRadius, 0),
      radius: Radius.circular(topLeftRadius),
    )
    // Top-right corner radius
    ..lineTo(size.width - topRightRadius, 0)
    ..arcToPoint(
      Offset(size.width, topRightRadius),
      radius: Radius.circular(topRightRadius),
    )
    // Right arc
    ..lineTo(size.width, size.height - position - (holeRadius * 2))
    ..arcToPoint(
      Offset(size.width, size.height - position),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    )
    ..lineTo(size.width, size.height - bottomRightRadius)
    // Bottom-right corner radius
    ..arcToPoint(
      Offset(size.width - bottomRightRadius, size.height),
      radius: Radius.circular(bottomRightRadius),
    )
    // Bottom-left corner radius
    ..lineTo(bottomLeftRadius, size.height)
    ..arcToPoint(
      Offset(0, size.height - bottomLeftRadius),
      radius: Radius.circular(bottomLeftRadius),
    )
    // Left arc
    ..lineTo(0, size.height - position)
    ..arcToPoint(
      Offset(0, size.height - position - (holeRadius * 2)),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    )
    // Close path to starting point (top-left)
    ..lineTo(0, topLeftRadius);

  return path;
}

Path _getHorizontalPath({
  required Size size,
  required double holeRadius,
  required double position,
  required double topLeftRadius,
  required double topRightRadius,
  required double bottomRightRadius,
  required double bottomLeftRadius,
}) {
  final radius = max(topLeftRadius, topRightRadius) +
      max(bottomLeftRadius, bottomRightRadius);
  position = position.clamp(radius * 2, size.width - radius);

  final path = Path()
    // Top-left border radius
    ..moveTo(0, topLeftRadius)
    ..arcToPoint(
      Offset(topLeftRadius, 0),
      radius: Radius.circular(topLeftRadius),
    )
    // Top arc
    ..lineTo(position - (holeRadius * 2), 0)
    ..arcToPoint(
      Offset(position, 0),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    )
    // Top-right border radius
    ..lineTo(size.width - topRightRadius, 0)
    ..arcToPoint(
      Offset(size.width, topRightRadius),
      radius: Radius.circular(topRightRadius),
    )
    // Bottom-right arc
    ..lineTo(size.width, size.height - bottomRightRadius)
    ..arcToPoint(
      Offset(size.width - bottomRightRadius, size.height),
      radius: Radius.circular(bottomRightRadius),
    )
    // Bottom arc
    ..lineTo(position, size.height)
    ..arcToPoint(
      Offset(position - (holeRadius * 2), size.height),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    )
    // Bottom-left corner radius
    ..lineTo(bottomLeftRadius, size.height)
    ..arcToPoint(
      Offset(0, size.height - bottomLeftRadius),
      radius: Radius.circular(bottomLeftRadius),
    )
    // Close path to starting point (top-left)
    ..lineTo(0, topLeftRadius);

  return path;
}
