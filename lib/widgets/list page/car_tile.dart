import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';
import 'package:mobcar/core/database.dart';

class CarTile extends StatelessWidget {
  final Car car;
  final Function() onTap;
  final Function() onDismiss;
  const CarTile({
    required this.onDismiss,
    required this.car,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final double size = 60;

  @override
  Widget build(BuildContext context) {
    bool hasImage = car.imageURL != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Dismissible(
        key: Key(car.id!),
        background: Container(color: Colors.red),
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
        onDismissed: (direction) async {
          await Database.deleteData(car: car);
          onDismiss();
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
                      child: Image.network(
                        car.imageURL!,
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
              car.model['nome'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.blue.shade700),
            ),
            subtitle: Text(car.year['nome'] + '\n' + car.manufacturer['nome']),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
