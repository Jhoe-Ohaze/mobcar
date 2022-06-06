import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobcar/core/car.dart';
import 'package:mobcar/core/database.dart';
import 'package:mobcar/core/item_page_bloc.dart';
import 'package:mobcar/core/list_page_bloc.dart';
import 'package:mobcar/widgets/item page/dropdown_manufacturers.dart';
import 'package:mobcar/widgets/item page/dropdown_models.dart';
import 'package:mobcar/widgets/item page/dropdown_years.dart';
import 'package:mobcar/widgets/item page/textfield_fipe.dart';
import 'package:mobcar/widgets/item%20page/image_frame.dart';
import 'package:mobcar/widgets/item%20page/submit_button.dart';

class CarItemPage extends StatefulWidget {
  final bool isEdit;
  final Uint8List? oldImage;
  final Car? oldCar;
  final String? documentID;

  const CarItemPage({
    required this.isEdit,
    this.oldCar,
    this.oldImage,
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

  Uint8List? currentImage;

  @override
  void initState() {
    super.initState();
    bloc.imageStream.listen((newImage) {
      currentImage = newImage;
    });

    bloc.getManufacturers();
    if (widget.isEdit) {
      bloc.getManufacturers();
      _manufacturerFieldKey.currentState!.setValue(widget.oldCar!.manufacturer);
      bloc.getModels(widget.oldCar!.manufacturer);
      _modelFieldKey.currentState!.setValue(widget.oldCar!.model);
      bloc.getYears(widget.oldCar!.model);
      _yearFieldKey.currentState!.setValue(widget.oldCar!.year);
      _fipeController.text = widget.oldCar!.fipe;
      if (widget.oldImage != null) {
        bloc.imageSink.add(widget.oldImage);
      }
    }
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

                Car newCar = Car(
                  manufacturer: _manufacturerFieldKey.currentState!.value,
                  model: _modelFieldKey.currentState!.value,
                  year: _yearFieldKey.currentState!.value,
                  fipe: _fipeController.text,
                );

                if (widget.isEdit) {
                  await Database.updateData(
                    oldData: widget.oldCar!,
                    newData: newCar,
                    oldImage: widget.oldImage,
                    newImage: currentImage,
                    documentID: widget.documentID!,
                  );
                } else {
                  await Database.saveData(
                    image: currentImage,
                    car: newCar,
                  );
                }

                await Future.delayed(const Duration(seconds: 1));
                ListPageBloc().getCarList();
                Navigator.of(firstContext).pop();
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
                ImageFrame(stream: bloc.imageStream, onTap: bloc.getImage),
                DropdownManufacturers(
                  stream: bloc.manufacturersStream,
                  buttonKey: _manufacturerFieldKey,
                  onChanged: (manufacturer) {
                    _modelFieldKey.currentState?.reset();
                    _yearFieldKey.currentState?.reset();
                    _fipeController.clear();
                    bloc.getModels(manufacturer);
                  },
                ),
                DropdownModels(
                  stream: bloc.modelsStream,
                  buttonKey: _modelFieldKey,
                  onChanged: (model) {
                    _yearFieldKey.currentState?.reset();
                    _fipeController.clear();
                    bloc.getYears(model);
                  },
                ),
                DropdownYears(
                  stream: bloc.yearsStream,
                  buttonKey: _yearFieldKey,
                  onChanged: bloc.getFipe,
                ),
                TextFieldFipe(
                  stream: bloc.fipeStream,
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
