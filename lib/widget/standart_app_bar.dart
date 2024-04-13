import 'package:flutter/material.dart';

import 'logo.dart';

class StandartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onTapBack;

  const StandartAppBar({
    super.key,
    this.onTapBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: onTapBack != null
          ? BackButton(
              onPressed: onTapBack,
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            )
          : null,
      title: const Logo(),
      centerTitle: true,
    );
  }
}
