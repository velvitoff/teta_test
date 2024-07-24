import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double size = constraints.maxWidth < constraints.maxHeight
          ? constraints.maxWidth * 0.35
          : constraints.maxHeight * 0.35;
      return SizedBox(
        width: size,
        height: size,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
