import 'dart:math';

import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  List<Alignment> alignList = [
    Alignment.topCenter,
    Alignment.center,
    Alignment.bottomCenter,
  ];
  List<String> chibiki = ['┏(-_-)┛', '┗(-_-)┓', '┗(-_-)┛', '┏(-_-)┓'];

  List<String> mixChibiki() {
    List<String> chibiki_ = List<String>.from(chibiki);
    List<String> newChibiki = [];

    while (chibiki_.isNotEmpty) {
      int N = Random().nextInt(chibiki_.length);
      newChibiki.add(chibiki_[N]);
      chibiki_.remove(chibiki_[N]);
    }

    return newChibiki;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => setState(() => chibiki = mixChibiki()),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Opacity(
        opacity: 0.6,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (String shibick in chibiki)
              AnimatedSwitcher(
                duration: Duration(milliseconds: 250 + Random().nextInt(250)),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  if (Random().nextBool()) {
                    return RotationTransition(
                      turns: animation,
                      alignment: alignList[Random().nextInt(3)],
                      child: child,
                    );
                  }

                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Text(
                  shibick,
                  key: ValueKey<List<String>>(chibiki),
                  style: textTheme.titleLarge!.copyWith(
                    letterSpacing: -3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
