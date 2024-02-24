import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 60.0),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 150,
          child: Image.asset('assets/images/flutter-logo.png'),
        ),
      ),
    );
  }
}
