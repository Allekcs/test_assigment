import 'package:fake_autarization/widget/logo.dart';
import 'package:flutter/material.dart';

class SpleshScreen extends StatelessWidget {
  const SpleshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Logo()),
    );
  }
}
