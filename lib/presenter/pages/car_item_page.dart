import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:smac_dart/smac.dart';

import '../../core/entities/car_brand_entity.dart';
import '../../core/entities/car_model_entity.dart';
import '../../core/entities/car_year_entity.dart';
import '../components/item/image_frame.dart';
import '../controllers/car_item_page_controller.dart';

class CarItemPage extends StatefulWidget {
  const CarItemPage({super.key});

  @override
  State<CarItemPage> createState() => _CarItemPageState();
}

class _CarItemPageState extends State<CarItemPage>
    with GetSmacMixin<CarItemPage, CarItemPageController> {
  @override
  CarItemPageController createSmac() => CarItemPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(smac.title),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: ValueListenableBuilder<bool>(
          valueListenable: smac.busyNotifier,
          builder: (context, busy, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  clipBehavior: Clip.hardEdge,
                  runSpacing: 10,
                  children: [
                    ValueListenableBuilder<Uint8List?>(
                      valueListenable: smac.imageNotifier,
                      builder: (context, image, child) {
                        return ImageFrame(
                          image: image,
                          onTap: busy ? null : () {},
                        );
                      },
                    ),
                    DropdownButtonFormField<CarBrandEntity>(
                      key: smac.brandFieldKey,
                      decoration: const InputDecoration(
                        label: Text("Marca"),
                      ),
                      value: smac.selectedBrand,
                      onChanged: busy ? null : smac.onBrandChange,
                      items: [
                        ...smac.brandsIter.map(
                          (brand) => DropdownMenuItem<CarBrandEntity>(
                            value: brand,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                brand.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<CarModelEntity>(
                      key: smac.modelsFieldKey,
                      decoration: const InputDecoration(
                        label: Text("Modelo"),
                      ),
                      value: smac.selectedModel,
                      onChanged: busy ? null : smac.onModelChange,
                      items: [
                        ...smac.modelsIter.map(
                          (model) => DropdownMenuItem<CarModelEntity>(
                            value: model,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                model.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<CarYearEntity>(
                      key: smac.yearsFieldKey,
                      decoration: const InputDecoration(
                        label: Text("Ano"),
                      ),
                      value: smac.selectedYear,
                      onChanged: busy ? null : smac.onYearChange,
                      items: [
                        ...smac.yearsIter.map(
                          (year) => DropdownMenuItem<CarYearEntity>(
                            value: year,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                year.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: smac.fipeController,
                      enabled: false,
                      decoration: const InputDecoration(
                        label: Text('FIPE'),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: busy
                          ? null
                          : (smac.fipe == null)
                              ? null
                              : smac.submit,
                      child: () {
                        if (busy) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
                            height: 60.0,
                            alignment: Alignment.center,
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }
                      }(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
