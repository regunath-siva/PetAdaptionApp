import 'package:flutter_test/flutter_test.dart';
import 'package:petadaptionapp/blocs/pet_event.dart';

void main() {
  group('PetEvent', () {
    test('LoadPets should be a subclass of PetEvent', () {
      final event = LoadPets();
      expect(event, isA<PetEvent>());
      expect(event, isA<LoadPets>());
    });

    test('AdoptPet should be a subclass of PetEvent', () {
      final petId = '1';
      final adoptedDatetime = DateTime.now();
      final event = AdoptPet(petId, adoptedDatetime);

      expect(event, isA<PetEvent>());
      expect(event, isA<AdoptPet>());
      expect(event.petId, petId);
      expect(event.adoptedDatetime, adoptedDatetime);
    });

    test('FilterPets should be a subclass of PetEvent', () {
      final query = 'Milo';
      final event = FilterPets(query);

      expect(event, isA<PetEvent>());
      expect(event, isA<FilterPets>());
      expect(event.query, query);
    });
  });
}
