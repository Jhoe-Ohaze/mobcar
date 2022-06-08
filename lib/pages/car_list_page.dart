import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';
import 'package:mobcar/core/list_page_bloc.dart';
import 'package:mobcar/pages/car_item_page.dart';
import 'package:mobcar/widgets/app_drawer.dart';
import 'package:mobcar/widgets/list%20page/car_tile.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  final bloc = ListPageBloc();

  @override
  void initState() {
    super.initState();
    bloc.getCarList();
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
              onPressed: () => bloc.getCarList(),
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
        onPressed: () async => await Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => const CarItemPage(
                  isEdit: false,
                ),
              ),
            )
            .then((value) => bloc.getCarList()),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Car>?>(
              stream: bloc.carsStream,
              builder: (context, snapshot) {
                bool hasData = snapshot.data?.isNotEmpty ?? snapshot.hasData;
                return hasData
                    ? ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          Car car = snapshot.data!.elementAt(index);
                          void onTap() async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  clipBehavior: Clip.hardEdge,
                                  contentPadding: const EdgeInsets.all(20),
                                  title: Text(
                                    car.model['nome'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.blue, fontSize: 18),
                                  ),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      car.imageURL != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                car.imageURL!,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.directions_car,
                                              size: 30,
                                            ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        child: Wrap(
                                          clipBehavior: Clip.antiAlias,
                                          direction: Axis.vertical,
                                          spacing: 10,
                                          children: [
                                            Text(
                                              car.model['nome'],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              car.manufacturer['nome'],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              car.year['nome'],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              car.fipe,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () async {
                                              await Navigator.of(context)
                                                  .push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CarItemPage(
                                                        isEdit: true,
                                                        oldCar: car,
                                                        documentID: car.id,
                                                      ),
                                                    ),
                                                  )
                                                  .then((value) =>
                                                      bloc.getCarList());
                                            },
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
                              },
                            );
                          }

                          return CarTile(
                            car: car,
                            onTap: onTap,
                            onDismiss: () => bloc.getCarList(),
                          );
                        },
                      )
                    : const Center(
                        child: Text('Não há carros cadastrados'),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
