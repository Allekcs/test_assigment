import 'package:flutter/material.dart';

class StandartButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool isSecondary;
  final bool isWarning;

  const StandartButton({
    super.key,
    required this.text,
    required this.onTap,
  })  : isSecondary = false,
        isWarning = false;

  const StandartButton.secondary({
    super.key,
    required this.text,
    required this.onTap,
  })  : isSecondary = true,
        isWarning = false;

  const StandartButton.warning({
    super.key,
    required this.text,
    required this.onTap,
  })  : isSecondary = false,
        isWarning = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyLarge;

    final buttonStyle = ButtonStyle(
      fixedSize: MaterialStateProperty.all(
        const Size.fromHeight(56),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    if (isSecondary) {
      return TextButton(
        onPressed: onTap,
        style: buttonStyle,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Text(
            text,
            style: textTheme!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    }

    if (isWarning) {
      return FilledButton(
        onPressed: onTap,
        style: buttonStyle.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith(
          (states) => Theme.of(context).colorScheme.error,
        )),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Text(
            text,
            style: textTheme!.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
          ),
        ),
      );
    }

    return FilledButton(
      onPressed: onTap,
      style: buttonStyle,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          text,
          style: textTheme!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
