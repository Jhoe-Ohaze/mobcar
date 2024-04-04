import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../../core/utils/typedefs.dart';

abstract class EntityMapper<T extends Equatable> {
  T fromMap(DataMap map);
  T fromJson(String json) => fromMap(jsonDecode(json));

  DataMap toMap(T entity);
  String toJson(T entity) => jsonEncode(toMap(entity));

  T fake();
}
