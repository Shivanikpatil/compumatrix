import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class PhoneInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PhoneInputWidget({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Mobile Number',
      hintText: 'Enter 10 digit number',
      keyboardType: TextInputType.phone,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '+91',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 24,
              width: 1,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
      validator: validator,
    );
  }
}
