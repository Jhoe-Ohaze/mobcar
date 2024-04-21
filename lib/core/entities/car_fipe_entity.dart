import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import 'car_brand_entity.dart';
import 'car_model_entity.dart';
import 'car_year_entity.dart';

class CarFipeEntity extends Equatable {
  final CarYearEntity year;
  final String fipe;
  final Uint8List? image;
  final String? code;
  final int? id;

  const CarFipeEntity({
    required this.year,
    required this.fipe,
    this.image,
    this.code,
    this.id,
  });

  CarModelEntity get model => year.model;
  CarBrandEntity get brand => model.brand;

  CarFipeEntity copyWith({
    CarYearEntity? year,
    String? fipe,
    Uint8List? Function()? image,
    String? Function()? code,
    int? Function()? id,
  }) {
    return CarFipeEntity(
      year: year ?? this.year,
      fipe: fipe ?? this.fipe,
      image:  image?.call() ?? this.image,
      code: code?.call() ?? this.code,
      id: id?.call() ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        code,
        image,
        year,
        fipe,
      ];
}
