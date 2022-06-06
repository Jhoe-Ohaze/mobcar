import 'package:flutter/material.dart';

class TextFieldFipe extends StatelessWidget {
  final Stream<String?> stream;
  final TextEditingController controller;
  const TextFieldFipe({
    required this.stream,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String label = 'FIPE';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          controller.text = snapshot.data!;
        }
        return TextField(
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
              label: Text(label),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              )),
        );
      },
    );
  }
}
