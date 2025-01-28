import 'package:hive/hive.dart';

import '../models/pet_model.dart';

class PetRepository {
  // Opening the Hive box to store the pets
  final Box<Pet> _petBox;

  PetRepository(this._petBox);

  // Fetch all pets from Hive
  List<Pet> getPets() {
    return _petBox.values.toList();
  }

  // Fetch only adopted pets
  List<Pet> getAdoptedPets() {
    return _petBox.values.where((pet) => pet.isAdopted).toList();
  }

  // Adopt a pet and update its status in Hive
  void adoptPet(String petId, DateTime adoptedDatetime) {
    // Get the pet from the box
    final pet = _petBox.values.firstWhere((p) => p.id == petId);

    // Update the pet's adoption status and adoption date
    pet.isAdopted = true;
    pet.adoptedDate = adoptedDatetime;

    // Save the updated pet back to the box using its ID as the key
    _petBox.put(pet.id, pet);
  }

  // Add a pet to the Hive box
  Future<void> addPet(Pet pet) async {
    await _petBox.add(pet);
  }

  // Optionally, clear the pet box (e.g., for testing purposes)
  Future<void> clearPets() async {
    await _petBox.clear();
  }
}
