import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';

class CarTile extends StatelessWidget {
  final Car car;
  final Function() onTap;
  const CarTile({
    required this.car,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasImage = car.imageURL != null;
    return Card(
      elevation: 2,
      child: ListTile(
        leading: hasImage
            ? Image.network(car.imageURL!)
            : const Icon(Icons.directions_car),
        title: Text(car.model.name),
        subtitle: Text(car.year.name),
        onTap: onTap,
      ),
    );
  }
}
