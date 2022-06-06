import 'package:flutter/material.dart';
import 'package:mobcar/pages/car_item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text('Procurar'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    Icons.filter_alt,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text('Não há carros cadastrados'),
            ),
          ),
        ],
      ),
    );
  }
}
