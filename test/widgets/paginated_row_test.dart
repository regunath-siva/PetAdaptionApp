import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petadaptionapp/widgets/paginated_row.dart'; // Adjust the import path

void main() {
  group('PaginatedRow Widget Tests', () {
    bool previousCalled = false;
    bool nextCalled = false;

    setUp(() {
      // Reset the flags before each test
      previousCalled = false;
      nextCalled = false;
    });

    testWidgets('disables Previous button on first page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaginatedRow(
              page: 1,
              pageSize: 10,
              isDarkMode: false,
              onPrevious: () => previousCalled = true,
              onNext: () => nextCalled = true,
              totalItems: 50,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that the "Previous" button is disabled
      final previousButton = tester.firstWidget<ElevatedButton>(
          find.byKey(const Key('previous_button')));
      expect(previousButton.onPressed,
          isNull); // It should be null because it's disabled
    });

    testWidgets('enables Next button when more data is available',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaginatedRow(
              page: 1,
              pageSize: 10,
              isDarkMode: false,
              onPrevious: () => previousCalled = true,
              onNext: () => nextCalled = true,
              totalItems: 50,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that the "Next" button is enabled
      final nextButton = tester
          .firstWidget<ElevatedButton>(find.byKey(const Key('next_button')));
      expect(nextButton.onPressed, isNotNull);

      // Tap the "Next" button and verify the onNext callback is called
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(nextCalled, true);
    });

    testWidgets('enables Previous button when not on the first page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaginatedRow(
              page: 2,
              pageSize: 10,
              isDarkMode: false,
              onPrevious: () => previousCalled = true,
              onNext: () => nextCalled = true,
              totalItems: 50,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the "Previous" button is enabled
      final previousButton = tester.firstWidget<ElevatedButton>(
          find.byKey(const Key('previous_button')));
      expect(previousButton.onPressed, isNotNull);

      // Tap the "Previous" button and verify the onPrevious callback is called
      await tester.tap(find.text('Previous'));
      await tester.pumpAndSettle();
      expect(previousCalled, true);
    });

    testWidgets('disables Next button on the last page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaginatedRow(
              page: 5, // Last page
              pageSize: 10,
              isDarkMode: false,
              onPrevious: () => previousCalled = true,
              onNext: () => nextCalled = true,
              totalItems: 50,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the "Next" button is disabled
      final nextButton = tester
          .firstWidget<ElevatedButton>(find.byKey(const Key('next_button')));
      expect(nextButton.onPressed,
          isNull); // It should be null because it's disabled
    });
  });
}
