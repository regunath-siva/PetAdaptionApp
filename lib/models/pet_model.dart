import 'package:hive/hive.dart';

part 'pet_model.g.dart'; // The generated part file for Hive

@HiveType(typeId: 0) // Use a unique typeId for your model
class Pet {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  bool isAdopted;

  @HiveField(6)
  DateTime? adoptedDate;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.imageUrl,
    this.adoptedDate,
    this.isAdopted = false,
  });

  Pet copyWith({
    String? id,
    String? name,
    int? age,
    double? price,
    String? imageUrl,
    bool? isAdopted,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAdopted: isAdopted ?? this.isAdopted,
    );
  }
}
