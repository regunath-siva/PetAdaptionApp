import '../models/pet_model.dart';

abstract class PetState {}

class PetLoading extends PetState {}

class PetLoaded extends PetState {
  final List<Pet> pets;

  PetLoaded(this.pets);
}

class PetAdopted extends PetState {
  final List<Pet> pets;

  PetAdopted(this.pets);
}
