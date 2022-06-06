import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';
import 'package:mobcar/widgets/list%20page/car_tile.dart';

class CarList extends StatelessWidget {
  final Stream<List<Car>?> stream;
  final Function() onTap;
  const CarList({required this.stream, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Car>?>(
      stream: stream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return CarTile(
                    car: snapshot.data!.elementAt(index),
                    onTap: onTap,
                  );
                },
              )
            : const Center(
                child: Text('Não há carros cadastrados'),
              );
      },
    );
  }
}
