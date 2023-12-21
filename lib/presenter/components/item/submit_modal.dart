import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SubmitModal extends StatelessWidget {
  final VoidCallback onConfirm;

  const SubmitModal({
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Salvar Alterações'),
      content: const Text('Tem certeza que deseja salvar estas alterações?'),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        TextButton(
          child: const Text('Confirmar'),
          onPressed: () {
            onConfirm();
            Modular.to.pop();
          },
        ),
      ],
    );
  }
}
