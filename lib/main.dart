import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './repositories/pet_repository.dart';
import 'blocs/pet_bloc.dart';
import 'blocs/pet_event.dart';
import 'routes.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => PetBloc(PetRepository())..add(LoadPets()),
      child: const MyApp(),
    ),
  );
}

class LoadPetsEvent {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption App',
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
