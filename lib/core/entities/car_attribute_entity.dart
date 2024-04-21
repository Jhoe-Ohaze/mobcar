import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CarAttributeEntity extends Equatable {
  final String id;
  final String name;
  
  const CarAttributeEntity({
    required this.id,
    required this.name,
  });

  @mustCallSuper
  @override
  List<Object?> get props => [
    id, 
    name,
  ];
}