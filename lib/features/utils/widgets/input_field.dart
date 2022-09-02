import 'package:flutter/material.dart';
import 'package:pt_tz/common/resources/utils/app_color.dart';
import 'package:pt_tz/common/resources/widgets/app_style.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixWidget;
  final bool obscureText;

  const InputField(
    this.controller, {
    this.hintText,
    super.key,
    this.suffixWidget,
    this.obscureText = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    final style = AppStyles.of(context);
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: widget.suffixWidget,
        hintText: widget.hintText ?? '',
        hintStyle: style.regularBody.copyWith(color: kSecondBorder),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: kSecondBorder),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kSecondBorder),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kSecondBorder),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }
}
