import 'package:flutter/material.dart';

import '../../../core/entities/car_fipe_entity.dart';

class CarTile extends StatelessWidget {
  final CarFipeEntity car;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const CarTile({
    required this.onDismiss,
    required this.car,
    required this.onTap,
    super.key,
  });

  final double size = 60.0;

  @override
  Widget build(BuildContext context) {
    bool hasImage = car.image != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Dismissible(
        key: Key(car.code!),
        background: Container(color: Colors.red),
        onDismissed: (direction) async => onDismiss(),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Excluir item'),
                content: const Text(
                    'Tem certeza que quer remover este item? Esta ação não pode ser revertida.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Confirmar'),
                  ),
                ],
              );
            },
          );
        },
        child: Card(
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            isThreeLine: true,
            leading: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              child: hasImage
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.memory(
                        car.image!,
                        height: size,
                        width: size,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      Icons.directions_car,
                      size: 40,
                    ),
            ),
            title: Text(
              car.model.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.blue.shade700),
            ),
            subtitle: Text('${car.year.name}\n${car.brand.name}'),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
