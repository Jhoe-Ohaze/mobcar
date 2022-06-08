class Car {
  final Map<String, dynamic> manufacturer;
  final Map<String, dynamic> model;
  final Map<String, dynamic> year;
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