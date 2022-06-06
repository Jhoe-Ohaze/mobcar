class Car {
  final Manufacturer manufacturer;
  final Model model;
  final Year year;
  final String fipe;
  String? imageURL;
  String? id;

  Car({
    required this.manufacturer,
    required this.model,
    required this.year,
    required this.fipe,
    this.imageURL,
    this.id,
  });
}

class Manufacturer {
  final String name;
  final String code;

  Manufacturer({required this.name, required this.code});
}

class Model {
  final Manufacturer manufacturer;
  final String name;
  final String code;

  Model({required this.name, required this.code, required this.manufacturer});
}

class Year {
  final Manufacturer manufacturer;
  final Model model;
  final String name;
  final String code;

  Year({
    required this.name,
    required this.code,
    required this.manufacturer,
    required this.model,
  });
}
