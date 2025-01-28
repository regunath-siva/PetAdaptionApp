import '../models/pet_model.dart';

class PetRepository {
  final List<Pet> _pets = [
    Pet(
      id: '1',
      name: 'Buddy',
      age: 2,
      price: 100.0,
      imageUrl: 'assets/images/dog1.jpg',
    ),
    Pet(
      id: '2',
      name: 'Mittens',
      age: 1,
      price: 80.0,
      imageUrl: 'assets/images/cat1.jpg',
    ),
    Pet(
      id: '3',
      name: 'Charlie',
      age: 3,
      price: 120.0,
      imageUrl: 'assets/images/cow1.jpg',
    ),
    Pet(
      id: '4',
      name: 'Luna',
      age: 2,
      price: 90.0,
      imageUrl: 'assets/images/cat2.png',
    ),
    Pet(
      id: '5',
      name: 'Max',
      age: 1,
      price: 85.0,
      imageUrl: 'assets/images/dog2.jpg',
    ),
    Pet(
      id: '6',
      name: 'Coco',
      age: 4,
      price: 150.0,
      imageUrl: 'assets/images/cow2.jpg',
    ),
    Pet(
      id: '7',
      name: 'Rocky',
      age: 3,
      price: 110.0,
      imageUrl: 'assets/images/cat1.jpg',
    ),
    Pet(
      id: '8',
      name: 'Bella',
      age: 2,
      price: 95.0,
      imageUrl: 'assets/images/dog1.jpg',
    ),
    Pet(
      id: '9',
      name: 'Daisy',
      age: 5,
      price: 140.0,
      imageUrl: 'assets/images/cow1.jpg',
    ),
    Pet(
      id: '10',
      name: 'Oscar',
      age: 1,
      price: 75.0,
      imageUrl: 'assets/images/cat2.png',
    ),
    Pet(
      id: '11',
      name: 'Max',
      age: 3,
      price: 85.0,
      imageUrl: 'assets/images/dog2.jpg',
    ),
    Pet(
      id: '12',
      name: 'Coco',
      age: 4,
      price: 150.0,
      imageUrl: 'assets/images/cow2.jpg',
    ),
    Pet(
      id: '13',
      name: 'Rocky',
      age: 3,
      price: 110.0,
      imageUrl: 'assets/images/cat1.jpg',
    ),
    Pet(
      id: '14',
      name: 'Bella',
      age: 2,
      price: 95.0,
      imageUrl: 'assets/images/dog1.jpg',
    ),
    Pet(
      id: '15',
      name: 'Daisy',
      age: 5,
      price: 140.0,
      imageUrl: 'assets/images/cow1.jpg',
    ),
    Pet(
      id: '16',
      name: 'Coco Two',
      age: 4,
      price: 150.0,
      imageUrl: 'assets/images/cow2.jpg',
    ),
    Pet(
      id: '17',
      name: 'Rocky Two',
      age: 3,
      price: 110.0,
      imageUrl: 'assets/images/cat1.jpg',
    ),
    Pet(
      id: '18',
      name: 'Bella Two',
      age: 2,
      price: 95.0,
      imageUrl: 'assets/images/dog1.jpg',
    ),
    Pet(
      id: '19',
      name: 'Daisy Two',
      age: 5,
      price: 140.0,
      imageUrl: 'assets/images/cow1.jpg',
    ),
    Pet(
      id: '20',
      name: 'Oscar Two',
      age: 1,
      price: 75.0,
      imageUrl: 'assets/images/cat2.png',
    ),
    Pet(
      id: '21',
      name: 'Max Three',
      age: 3,
      price: 85.0,
      imageUrl: 'assets/images/dog2.jpg',
    ),
    Pet(
      id: '22',
      name: 'Coco Three',
      age: 4,
      price: 150.0,
      imageUrl: 'assets/images/cow2.jpg',
    ),
    Pet(
      id: '23',
      name: 'Rocky Three',
      age: 3,
      price: 110.0,
      imageUrl: 'assets/images/cat1.jpg',
    ),
    Pet(
      id: '24',
      name: 'Bella Three',
      age: 2,
      price: 95.0,
      imageUrl: 'assets/images/dog1.jpg',
    ),
    Pet(
      id: '25',
      name: 'Daisy Three',
      age: 5,
      price: 140.0,
      imageUrl: 'assets/images/cow1.jpg',
    ),
  ];

  // Returns the complete list of pets
  List<Pet> getPets() => _pets;

  // Returns only the adopted pets
  List<Pet> getAdoptedPets() => _pets.where((pet) => pet.isAdopted).toList();

  // Marks a specific pet as adopted based on its ID
  void adoptPet(String petId, DateTime adoptedDatetime) {
    final pet = _pets.firstWhere((p) => p.id == petId);
    pet.isAdopted = true;
    pet.adoptedDate = adoptedDatetime;
  }
}
