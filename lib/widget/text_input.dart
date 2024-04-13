import 'package:flutter/material.dart';

import '../services/obscuring_controller.dart';

class TextInput extends StatefulWidget {
  final TextStyle? textStyle;
  final String labelText;
  final TextEditingController? controller;

  final FocusNode? focusNode;
  final bool isObscuring;

  const TextInput({
    super.key,
    required this.textStyle,
    required this.labelText,
    this.controller,
    this.focusNode,
  }) : isObscuring = false;

  const TextInput.obscuring({
    super.key,
    required this.textStyle,
    required this.labelText,
    this.controller,
    this.focusNode,
  }) : isObscuring = true;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final textControllerObscure = ObscuringTextEditingController();
  final textController = TextEditingController();

  bool isVisible = false;

  void onTabVisible() => setState(() {
        isVisible = !isVisible;
        if (isVisible) {
          switchController(
            textControllerObscure,
            textController,
          );
        } else {
          switchController(
            textController,
            textControllerObscure,
          );
        }
      });

  void switchController(
    TextEditingController originController,
    TextEditingController controller,
  ) {
    controller.text = originController.text;
    controller.selection = TextSelection.collapsed(
      offset: originController.text.length,
    );
  }

  void edingText(TextEditingController controller) {
    widget.controller!.text = controller.text;
  }

  @override
  void initState() {
    if (widget.controller == null) return;

    textController.text = widget.controller!.text;
    textControllerObscure.text = widget.controller!.text;

    textController.addListener(
      () => edingText(textController),
    );
    textControllerObscure.addListener(
      () => edingText(textControllerObscure),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = widget.focusNode ?? FocusNode();
    TextEditingController controller;

    if (widget.isObscuring) {
      controller = isVisible ? textController : textControllerObscure;
    } else {
      controller = textController;
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: widget.textStyle,
      decoration: InputDecoration(
        labelText: widget.labelText,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 2,
        ),
        suffixIcon: widget.isObscuring
            ? visibleButton(
                onTap: onTabVisible,
                isVisible: isVisible,
              )
            : null,
      ),
      onTapOutside: (event) => {
        focusNode.unfocus(disposition: UnfocusDisposition.scope),
      },
    );
  }

  Widget visibleButton({
    required Function() onTap,
    required bool isVisible,
  }) {
    return IconButton(
      icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
      onPressed: onTap,
    );
  }
}
