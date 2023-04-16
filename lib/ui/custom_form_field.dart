
import 'package:flutter/material.dart';
import 'package:todo_app/ui/design_colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    required this.icon,
    this.suffixIcon,
    this.validator,
    required this.hintText,
    this.enabled = true,
  }) : super(key: key);
  final TextEditingController controller;
  final IconData icon;
  final IconData? suffixIcon;
  final String hintText;
  final String? validator;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return validator;
          }
          return null;
        },
        onTapOutside: (event) {
          final currentFocus = FocusScope.of(context);
          if (currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: DesignColor.textFocus,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: DesignColor.textnotFocus,
          ),
          prefixIcon: Icon(
            icon,
            size: 16,
            color: DesignColor.todoBlue,
          ),
          suffixIcon: suffixIcon == null
              ? null
              : Icon(
                  suffixIcon,
                  size: 16,
                  color: DesignColor.todoBlue,
                ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: DesignColor.todoBorder, width: 1.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: DesignColor.todoBorder, width: 1),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: DesignColor.todoBorder, width: 1),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: DesignColor.todoBorder, width: 1),
          ),
          errorStyle: const TextStyle(color: Colors.red),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
