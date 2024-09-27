import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextfields extends StatelessWidget {
  final TextEditingController controller;
  final String labettxt;
  final String hinttxt;
  final bool visibility;
  final IconData? prefixIcon;
  final String? Function(dynamic value) validator; // Use the validator in the field

  const CustomTextfields({
    Key? key,
    required this.controller,
    required this.labettxt,
    required this.hinttxt,
    this.prefixIcon,
    this.visibility = false,
    required this.validator, // Ensure this is required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(0), // Padding inside the container
        child: TextFormField(
          controller: controller,
          obscureText: visibility,
          validator: validator, // Pass the validator to the TextFormField
          decoration: InputDecoration(
            labelText: labettxt,
            hintText: hinttxt,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.primarygrey, width: 1.0),
              borderRadius: BorderRadius.circular(18),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.primarygrey, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            fillColor: Colors.purple.withOpacity(0.1), // Text field's inner fill color
            filled: true, // Ensure the inner fill is applied
            labelStyle: const TextStyle(fontSize: 15),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
