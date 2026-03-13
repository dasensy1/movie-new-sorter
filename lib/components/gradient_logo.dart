import 'package:flutter/material.dart';

class GradientLogo extends StatelessWidget {
  const GradientLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFB0B0B0),
            Color(0xFFE0E0E0),
            Color(0xFF909090),
          ],
          stops: [0.0, 0.33, 0.66, 1.0],
        ).createShader(bounds);
      },
      child: const Text(
        'ViaFilms',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ),
    );
  }
}
