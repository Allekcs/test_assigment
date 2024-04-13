import 'package:fake_autarization/application/route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        textTheme: GoogleFonts.mulishTextTheme(textTheme).apply(
          bodyColor: const Color(0xFF000000),
          displayColor: const Color(0xFF000000),
        ),
      ),
      routes: routes,
    );
  }
}
