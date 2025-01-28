class Pet {
  final String id;
  final String name;
  final int age;
  final double price;
  final String imageUrl;
  bool isAdopted;
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
}
