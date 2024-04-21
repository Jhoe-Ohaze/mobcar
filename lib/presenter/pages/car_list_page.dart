import 'package:flutter/material.dart';
import 'package:smac_dart/smac.dart';

import '../../core/entities/car_fipe_entity.dart';
import '../components/app_drawer.dart';
import '../components/list/car_tile.dart';
import '../controllers/car_list_page_controller.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage>
    with GetSmacMixin<CarListPage, CarListPageController> {
  @override
  CarListPageController createSmac() => CarListPageController();

  @override
  void initState() {
    super.initState();
    smac.onInitState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('MOBCAR'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: smac.getCarList,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: smac.onFabPressed,
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
      body: ValueListenableBuilder<Iterable<CarFipeEntity>>(
        valueListenable: smac.savedCarsNotifier,
        builder: (context, savedCars, child) {
          if (savedCars.isNotEmpty) {
            return ListView.separated(
              itemCount: savedCars.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10.0);
              },
              itemBuilder: (context, index) {
                return CarTile(
                  car: savedCars.elementAt(index),
                  onDismiss: () => smac.deleteCar(index),
                  onTap: () => smac.showDetailsModal(
                    context: context,
                    car: savedCars.elementAt(index),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Não há carros cadastrados'),
            );
          }
        },
      ),
    );
  }
}
