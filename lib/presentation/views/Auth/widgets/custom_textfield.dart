import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? suffixIcon;
  final Icon prefixIcon;
  final bool obscureText;
  final VoidCallback ontap;
  final VoidCallback? onChanged;
  final TextInputType keyboardType;
  final FormFieldValidator validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    required this.prefixIcon,
    required this.obscureText,
    required this.ontap,
    this.onChanged,
    required this.keyboardType,
    required this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) => widget.onChanged,
      onTap: widget.ontap,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText && !isPasswordVisible,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  if (widget.obscureText) {
                    setState(() => isPasswordVisible = !isPasswordVisible);
                  }
                },
                icon: Icon(isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
            : null,
        suffixIconColor: primaryColor,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: primaryColor,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusColor: primaryColor,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
