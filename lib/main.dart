import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import './repositories/pet_repository.dart';
import 'blocs/pet_bloc.dart';
import 'blocs/pet_event.dart';
import 'models/data.dart';
import 'models/pet_model.dart';
import 'routes.dart';

void main() async {
  await Hive.initFlutter(); // Initialize Hive

  // Register the adapter for Pet model
  Hive.registerAdapter(PetAdapter());

  // Open a Hive box for pets
  var petBox = await Hive.openBox<Pet>('petsBox');

  // Add initial pets if box is empty
  if (petBox.isEmpty) {
    await addInitialPets(petBox);
  }

  runApp(
    BlocProvider(
      create: (context) => PetBloc(PetRepository(petBox))..add(LoadPets()),
      child: const MyApp(),
    ),
  );
}

// Function to add initial pet data to Hive
Future<void> addInitialPets(Box<Pet> petsBox) async {
  for (var pet in initialPets) {
    await petsBox.put(pet.id, pet); // Save pet data to Hive box
  }
}

class LoadPetsEvent {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption Assessment Task',
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
