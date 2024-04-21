import 'package:flutter/material.dart';

import '../../../core/entities/car_fipe_entity.dart';

class CarDetailsModalWidget extends StatelessWidget {
  final CarFipeEntity car;
  final VoidCallback editCallback;

  const CarDetailsModalWidget({
    required this.car,
    required this.editCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: const EdgeInsets.all(20.0),
      title: Text(
        car.model.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 18.0,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (car.image != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.memory(
                car.image!,
                fit: BoxFit.fitWidth,
              ),
            ),
          ] else ...[
            const Icon(
              Icons.directions_car,
              size: 30.0,
            ),
          ],
          const SizedBox(height: 15.0),
          SizedBox(
            child: Wrap(
              clipBehavior: Clip.antiAlias,
              direction: Axis.vertical,
              spacing: 10.0,
              children: [
                Text(
                  car.model.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  car.brand.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  car.year.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  car.fipe,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: editCallback,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 14,
                ),
                label: const Text('Editar'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Reservar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
