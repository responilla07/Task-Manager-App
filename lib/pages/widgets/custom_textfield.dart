import 'package:flutter/material.dart';
import 'package:task_manager/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? enabled;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool readOnly;
  const CustomTextField({
    super.key,
    this.controller,
    this.maxLines = 1,
    this.hintText,
    this.keyboardType,
    this.enabled,
    this.validator,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLines: maxLines,
      onTap: onTap,
      style: const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
        hintText: hintText,
        labelText: hintText,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryL, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorMaxLines: 2,
        fillColor: AppColors.grey.withOpacity(.15),
        filled: true,
      ),
      readOnly: readOnly,
      validator: validator,
      controller: controller,
    );
  }
}
