import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';

class CarList extends StatelessWidget {
  final List<Car> list;
  const CarList({required this.list, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 60),
      itemCount: list.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
