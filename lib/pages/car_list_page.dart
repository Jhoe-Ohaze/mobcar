import 'package:flutter/material.dart';
import 'package:mobcar/core/list_page_bloc.dart';
import 'package:mobcar/pages/car_item_page.dart';
import 'package:mobcar/widgets/list%20page/car_list.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  final bloc = ListPageBloc();

  void gotoItemPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CarItemPage(isEdit: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOBCAR'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: gotoItemPage,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                label: Text('Procurar'),
              ),
            ),
          ),
          Expanded(
            child: CarList(
              stream: bloc.carsStream,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
