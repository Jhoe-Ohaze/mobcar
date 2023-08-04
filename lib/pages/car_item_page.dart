import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../core/car.dart';
import '../core/item_page_bloc.dart';
import '../widgets/item page/textfield_fipe.dart';
import '../widgets/item%20page/dropdown_field.dart';
import '../widgets/item%20page/image_frame.dart';
import '../widgets/item%20page/submit_button.dart';

class CarItemPage extends StatefulWidget {
  final bool isEdit;
  final Car? oldCar;
  final String? documentID;

  const CarItemPage({
    required this.isEdit,
    this.oldCar,
    this.documentID,
    Key? key,
  }) : super(key: key);

  @override
  State<CarItemPage> createState() => _CarItemPageState();
}

class _CarItemPageState extends State<CarItemPage> {
  final bloc = ItemPageBloc();

  final _manufacturerFieldKey = GlobalKey<FormFieldState>();
  final _modelFieldKey = GlobalKey<FormFieldState>();
  final _yearFieldKey = GlobalKey<FormFieldState>();
  final _fipeController = TextEditingController();

  Uint8List? oldImage;

  @override
  void initState() {
    super.initState();
    bloc.getManufacturers();
  }

  void initFields() async {
    dynamic loadingContext;

    showDialog(
      context: context,
      builder: (dialogContext) {
        loadingContext = dialogContext;
        return AlertDialog(
          title: const Text(
            'Carregando Dados',
            style: TextStyle(color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          contentPadding: const EdgeInsets.all(50),
          content: Container(
            height: MediaQuery.of(context).size.width * 0.3,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
    await bloc.initEditionFields(widget.oldCar!);

    Navigator.of(loadingContext).pop();
  }

  void submit() async {
    dynamic loadingContext;
    showDialog(
      context: context,
      builder: (firstContext) {
        return AlertDialog(
          title: const Text('Salvar Alterações'),
          content:
              const Text('Tem certeza que deseja salvar estas alterações?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(firstContext).pop(),
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () async {
                Navigator.of(firstContext).pop();
                showDialog(
                  context: context,
                  builder: (secondContext) {
                    loadingContext = secondContext;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.4),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  },
                );

                if (widget.isEdit) {
                  await bloc.updateData(widget.oldCar!, widget.documentID!);
                } else {
                  await bloc.saveData();
                }

                await Future.delayed(const Duration(seconds: 3));
                Navigator.of(loadingContext).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.isEdit ? 'Editar Carro' : 'Adicionar Carro';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isEdit) {
        initFields();
      }
    });
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
              alignment: WrapAlignment.center,
              clipBehavior: Clip.hardEdge,
              runSpacing: 10,
              children: [
                ImageFrame(
                    stream: bloc.imageBehavior.stream, onTap: bloc.getImage),
                DropdownField(
                  fieldName: 'Fabricante',
                  listStream: bloc.listManufacturerBehavior.stream,
                  itemStream: bloc.manufacturerBehavior.stream,
                  buttonKey: _manufacturerFieldKey,
                  onChanged: (manufacturer) async {
                    _modelFieldKey.currentState?.reset();
                    _yearFieldKey.currentState?.reset();
                    _fipeController.clear();
                    bloc.manufacturerSink.add(manufacturer);
                    bloc.getModels(manufacturer: manufacturer!);
                  },
                ),
                DropdownField(
                  fieldName: 'Modelo',
                  listStream: bloc.listModelBehavior.stream,
                  itemStream: bloc.modelBehavior.stream,
                  buttonKey: _modelFieldKey,
                  onChanged: (model) async {
                    _yearFieldKey.currentState?.reset();
                    _fipeController.clear();
                    bloc.modelSink.add(model);
                    bloc.getYears(
                      manufacturer: bloc.manufacturerBehavior.value!,
                      model: model!,
                    );
                  },
                ),
                DropdownField(
                  fieldName: 'Ano',
                  listStream: bloc.listYearBehavior.stream,
                  itemStream: bloc.yearBehavior.stream,
                  buttonKey: _yearFieldKey,
                  onChanged: (year) async {
                    bloc.yearSink.add(year);
                    bloc.getFipe(
                      manufacturer: bloc.manufacturer!,
                      model: bloc.model!,
                      year: year!,
                    );
                  },
                ),
                TextFieldFipe(
                  stream: bloc.fipeBehavior.stream,
                  controller: _fipeController,
                ),
                SubmitButton(
                  stream: bloc.submitStream,
                  onPressed: submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
