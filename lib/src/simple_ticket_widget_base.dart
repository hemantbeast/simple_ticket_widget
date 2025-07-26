import 'dart:math';

import 'package:flutter/material.dart';

/// A simple ticket widget to display it vertically or horizontally.
class SimpleTicketWidget extends StatelessWidget {
  /// Creates a simple ticket widget.
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

  /// The position of the arc based on direction. Default set to 100.
  final double position;

  /// The circular arc radius of ticket. Default set to 16.
  final double arcRadius;

  /// The shadow blur radius of the ticket. Default set to 4.
  final double blurRadius;

  /// The corner radius of the ticket. Default set to BorderRadius.zero.
  final BorderRadius borderRadius;

  /// The shadow color of the ticket. Default set to Colors.black54.
  final Color shadowColor;

  /// The direction of the ticket widget arc. Default set to Axis.vertical.
  final Axis direction;

  /// The child widget to be clipped.
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

/// A custom painter to draw the shadow of the ticket.
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

/// A custom clipper to clip the ticket.
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

/// Returns a path for a vertical ticket.
Path _getVerticalPath({
  required Size size,
  required double holeRadius,
  required double position,
  required double topLeftRadius,
  required double topRightRadius,
  required double bottomRightRadius,
  required double bottomLeftRadius,
}) {
  final radius = max(topLeftRadius, topRightRadius) + max(bottomLeftRadius, bottomRightRadius);
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

/// Returns a path for a horizontal ticket.
Path _getHorizontalPath({
  required Size size,
  required double holeRadius,
  required double position,
  required double topLeftRadius,
  required double topRightRadius,
  required double bottomRightRadius,
  required double bottomLeftRadius,
}) {
  final radius = max(topLeftRadius, topRightRadius) + max(bottomLeftRadius, bottomRightRadius);
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
