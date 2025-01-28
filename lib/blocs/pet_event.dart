abstract class PetEvent {}

class LoadPets extends PetEvent {}

class AdoptPet extends PetEvent {
  final String petId;
  final DateTime adoptedDatetime;

  AdoptPet(this.petId, this.adoptedDatetime);
}

class FilterPets extends PetEvent {
  final String query;

  FilterPets(this.query);
}
