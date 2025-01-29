import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petadaptionapp/blocs/pet_bloc.dart';
import 'package:petadaptionapp/blocs/pet_event.dart';
import 'package:petadaptionapp/blocs/pet_state.dart';
import 'package:petadaptionapp/models/pet_model.dart';
import 'package:petadaptionapp/repositories/pet_repository.dart';

import 'pet_bloc_test.mocks.dart';

@GenerateMocks([PetRepository])
void main() {
  late PetBloc petBloc;
  late MockPetRepository mockPetRepository;

  final testPets = [
    Pet(
        id: '1',
        name: 'Buddy',
        age: 2,
        price: 5000,
        imageUrl: 'assets/dog.png',
        isAdopted: false),
    Pet(
        id: '2',
        name: 'Milo',
        age: 3,
        price: 7000,
        imageUrl: 'assets/cat.png',
        isAdopted: false),
  ];

  setUp(() {
    mockPetRepository = MockPetRepository();
    when(mockPetRepository.getPets()).thenReturn(testPets);
    petBloc = PetBloc(mockPetRepository);
  });

  tearDown(() {
    petBloc.close();
  });

  test('initial state is PetLoading', () {
    expect(petBloc.state, isA<PetLoading>());
  });

  test('emits [PetLoaded] when LoadPets is added', () {
    petBloc.add(LoadPets());

    expectLater(
      petBloc.stream,
      emitsInOrder([
        isA<PetLoaded>(), // Expecting PetLoaded type
      ]),
    );
  });

  test('emits updated PetLoaded after AdoptPet event', () {
    when(mockPetRepository.getPets()).thenReturn([
      testPets[0].copyWith(isAdopted: true),
      testPets[1],
    ]);

    petBloc.add(AdoptPet(testPets[0].id, DateTime.now()));

    expectLater(
      petBloc.stream,
      emitsInOrder([
        isA<PetLoaded>(), // Expecting PetLoaded type
      ]),
    );
  });

  test('emits filtered pets when FilterPets event is added', () {
    when(mockPetRepository.getPets()).thenReturn(testPets);

    petBloc.add(FilterPets('Milo'));

    expectLater(
      petBloc.stream,
      emitsInOrder([
        isA<PetLoaded>(), // Expecting PetLoaded type
      ]),
    );
  });
}
