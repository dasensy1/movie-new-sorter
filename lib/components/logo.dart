import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  final Color? color;

  const Logo({
    super.key,
    this.size = 80,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? Colors.white;
    final triangleSize = size / 2.5;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: CustomPaint(
              size: Size(triangleSize, triangleSize),
              painter: TrianglePainter(
                color: logoColor,
                pointingDown: true,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: Size(triangleSize, triangleSize),
              painter: TrianglePainter(
                color: logoColor,
                pointingDown: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool pointingDown;

  TrianglePainter({
    required this.color,
    required this.pointingDown,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (pointingDown) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width / 2, 0);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TrianglePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.pointingDown != pointingDown;
  }
}
