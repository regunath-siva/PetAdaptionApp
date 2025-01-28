import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/pet_repository.dart';
import 'pet_event.dart';
import 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository petRepository;

  PetBloc(this.petRepository) : super(PetLoading()) {
    on<LoadPets>((event, emit) {
      emit(PetLoaded(petRepository.getPets()));
    });

    on<AdoptPet>((event, emit) {
      petRepository.adoptPet(event.petId, event.adaptedDatetime);
      emit(PetLoaded(petRepository.getPets()));
    });

    // on<FilterPets>((event, emit) {
    //   final filteredPets = petRepository.getPets().where((pet) {
    //     return pet.name.toLowerCase().contains(event.query.toLowerCase());
    //   }).toList();
    //   emit(PetLoaded(filteredPets));
    // });

    on<FilterPets>((event, emit) {
      final query = event.query
          .toLowerCase(); // Convert query to lowercase for case-insensitive search

      final filteredPets = petRepository.getPets().where((pet) {
        return pet.name.toLowerCase().contains(query) || // Match by name
            pet.age.toString() == query || // Match by age
            pet.price.toStringAsFixed(0).contains(query); // Match by price
      }).toList();

      emit(PetLoaded(filteredPets));
    });
  }
}
