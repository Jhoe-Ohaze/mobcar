import 'package:flutter/material.dart';

class CarItemPage extends StatelessWidget {
  final bool isEdit;
  const CarItemPage({required this.isEdit, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String title = isEdit ? 'Editar Carro' : 'Adicionar Carro';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              runSpacing: 10,
              children: const [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
