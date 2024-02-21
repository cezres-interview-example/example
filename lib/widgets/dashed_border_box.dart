import 'package:flutter/material.dart';

class DashedBorderBox extends StatelessWidget {
  const DashedBorderBox({
    super.key,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    required this.borderColor,
    required this.borderWidth,
    required this.dashWidth,
    required this.dashSpace,
    this.child,
  });

  final EdgeInsets? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double dashWidth;
  final double dashSpace;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderBoxPainter(
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        borderColor: borderColor,
        borderWidth: borderWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: padding != null ? Padding(padding: padding!, child: child) : child,
    );
  }
}

class _DashedBorderBoxPainter extends CustomPainter {
  const _DashedBorderBoxPainter({
    this.backgroundColor,
    this.borderRadius,
    required this.borderColor,
    required this.borderWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) {
      return;
    }

    final Paint paint = Paint();

    // Draw background
    if (backgroundColor != null) {
      paint.color = backgroundColor!;
      paint.style = PaintingStyle.fill;
      final rect = Rect.fromLTWH(0, 0, size.width, size.height);
      if (borderRadius != null) {
        final rrect = RRect.fromRectAndCorners(
          rect,
          topLeft: borderRadius!.topLeft,
          topRight: borderRadius!.topRight,
          bottomLeft: borderRadius!.bottomLeft,
          bottomRight: borderRadius!.bottomRight,
        );
        canvas.drawRRect(rrect, paint);
      } else {
        canvas.drawRect(rect, paint);
      }
    }

    if (dashWidth <= 0 || dashSpace <= 0) {
      return;
    }

    // Border path
    final path = Path();

    // Add top and bottom path
    var start = borderRadius != null ? borderRadius!.topLeft.x : dashSpace;
    var end = size.width -
        (borderRadius != null ? borderRadius!.topRight.x : dashSpace);

    final horizontalPath = _calculatePath(
      start,
      end,
      (start) => (
        Offset(start, borderWidth / 2),
        Offset(start + dashWidth, borderWidth / 2)
      ),
    );
    path.addPath(horizontalPath, Offset.zero);
    path.addPath(horizontalPath, Offset(0, size.height - borderWidth));

    // // Add left and right path
    start = borderRadius != null ? borderRadius!.topLeft.y : dashSpace;
    end = size.height -
        (borderRadius != null ? borderRadius!.bottomLeft.y : dashSpace);
    final verticalPath = _calculatePath(
      start,
      end,
      (start) => (
        Offset(borderWidth / 2, start),
        Offset(borderWidth / 2, start + dashWidth)
      ),
    );
    path.addPath(verticalPath, Offset.zero);
    path.addPath(verticalPath, Offset(size.width - borderWidth, 0));

    // Draw border
    paint.color = borderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = borderWidth;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _DashedBorderBoxPainter) {
      return oldDelegate.backgroundColor != backgroundColor ||
          oldDelegate.borderRadius != borderRadius ||
          oldDelegate.borderColor != borderColor ||
          oldDelegate.borderWidth != borderWidth ||
          oldDelegate.dashWidth != dashWidth ||
          oldDelegate.dashSpace != dashSpace;
    }
    return true;
  }

  Path _calculatePath(
    double start,
    double end,
    (Offset, Offset) Function(double start) builder,
  ) {
    final space = _calculateSpace(start, end, dashWidth, dashSpace);
    final path = Path();
    var s = start;
    while (s <= end) {
      final (p1, p2) = builder(s);
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(p2.dx, p2.dy);
      s += dashWidth + space;
    }
    return path;
  }

  // Calculate space between dash
  double _calculateSpace(
    double start,
    double end,
    double dashWidth,
    double dashSpace,
  ) {
    final width = end - start;
    final count = ((width + dashSpace) / (dashWidth + dashSpace)).round();
    return (width - count * dashWidth) / (count - 1);
  }
}
