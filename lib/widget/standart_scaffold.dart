import 'package:flutter/material.dart';

import 'standart_app_bar.dart';

class StandartScaffold extends StatelessWidget {
  final List<Widget> children;
  final StandartAppBar? appBar;

  const StandartScaffold({
    super.key,
    this.appBar,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? const StandartAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
