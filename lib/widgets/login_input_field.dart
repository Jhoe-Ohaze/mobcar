import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  const LoginInputField({
    required this.icon,
    required this.label,
    required this.obscure,
    required this.stream,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              icon: Icon(icon),
              labelText: label,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.outline)),
              errorText: snapshot.hasError ? snapshot.error.toString() : null),
          obscureText: obscure,
          onChanged: onChanged,
        );
      },
    );
  }
}
