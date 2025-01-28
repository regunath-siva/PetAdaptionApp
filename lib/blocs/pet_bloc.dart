import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/pet_repository.dart';
import 'pet_event.dart';
import 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository petRepository;

  PetBloc(this.petRepository) : super(PetLoading()) {
    on<LoadPets>((event, emit) {
      final pets = petRepository.getPets();
      emit(PetLoaded(pets));
    });

    on<AdoptPet>((event, emit) {
      petRepository.adoptPet(event.petId, event.adoptedDatetime);
      final pets = petRepository.getPets();
      emit(PetLoaded(pets));
    });

    on<FilterPets>((event, emit) {
      final query = event.query.toLowerCase();
      final filteredPets = petRepository.getPets().where((pet) {
        return pet.name.toLowerCase().contains(query) ||
            pet.age.toString() == query ||
            pet.price.toStringAsFixed(0).contains(query);
      }).toList();

      emit(PetLoaded(filteredPets));
    });
  }
}
