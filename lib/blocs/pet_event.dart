abstract class PetEvent {}

class LoadPets extends PetEvent {}

class AdoptPet extends PetEvent {
  final String petId;
  final DateTime adaptedDatetime;

  AdoptPet(this.petId, this.adaptedDatetime);
}

class FilterPets extends PetEvent {
  final String query;

  FilterPets(this.query);
}
