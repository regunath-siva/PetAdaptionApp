import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petadaptionapp/models/pet_model.dart';
import 'package:petadaptionapp/routes.dart';
import 'package:petadaptionapp/widgets/pet_card.dart';

void main() {
  group('PetCard Widget Tests', () {
    final testPet = Pet(
      id: '1',
      name: 'Buddy',
      age: 2,
      price: 5000,
      imageUrl: 'assets/images/dog1.jpg',
      isAdopted: false,
    );

    testWidgets('Displays pet details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PetCard(pet: testPet),
          ),
        ),
      );

      expect(find.text('Buddy'), findsOneWidget);
      expect(find.text('2 years'), findsOneWidget);
      final priceWidget =
          tester.widget<Text>(find.byKey(Key('pet_price_${testPet.id}')));
      expect(priceWidget.data, '₹${testPet.price}');

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Navigates to pet details page on tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.details: (context) =>
                const Scaffold(body: Text('Pet Details')),
          },
          home: Scaffold(
            body: PetCard(pet: testPet),
          ),
        ),
      );

      await tester.tap(find.byKey(Key('pet_card_${testPet.id}')));
      await tester.pumpAndSettle();

      expect(find.text('Pet Details'), findsOneWidget);
    });

    testWidgets('Adopt button is enabled for available pets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PetCard(pet: testPet),
          ),
        ),
      );

      final adoptButton =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(adoptButton.enabled, isTrue);
    });

    // testWidgets('Adopt button is disabled for already adopted pets', (WidgetTester tester) async {
    //   final adoptedPet = testPet.copyWith(isAdopted: true);
    //
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(
    //         body: PetCard(pet: adoptedPet),
    //       ),
    //     ),
    //   );
    //
    //   final adoptButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    //   expect(adoptButton.enabled, isFalse);
    //   expect(find.text('Already Adopted'), findsOneWidget);
    // });
  });
}
