import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Stream<bool> stream;
  final Function() onPressed;

  const SubmitButton({
    required this.stream,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) {
        bool hasData = snapshot.data != null;
        return ElevatedButton(
          onPressed: hasData ? onPressed : null,
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: const Text(
              'Salvar',
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
