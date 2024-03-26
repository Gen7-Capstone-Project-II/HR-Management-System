
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
 * PasswordInputField
 */
class PasswordInputField extends StatefulWidget {
  
  final TextEditingController controller;
  final String label;
  final int length;
  final FormFieldValidator<String> validator;
  const PasswordInputField({Key? key, required this.controller, required this.label, required this.validator, this.length = 15}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      obscureText: !_showPassword,
      validator: widget.validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.length)
      ],
    );
  }
}