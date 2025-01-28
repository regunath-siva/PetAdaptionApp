import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/pet_bloc.dart';
import '../blocs/pet_state.dart';
import '../models/pet_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption History'),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          if (state is PetLoaded) {
            // Filter pets that have been adopted
            final adoptedPets =
                state.pets.where((pet) => pet.isAdopted).toList();

            // Sort the pets by adoption date (assuming 'adoptedDate' is available)
            adoptedPets
                .sort((a, b) => a.adoptedDate!.compareTo(b.adoptedDate!));

            if (adoptedPets.isEmpty) {
              return const Center(
                child: Text('No pets have been adopted yet.'),
              );
            }

            return ListView.builder(
              itemCount: adoptedPets.length,
              itemBuilder: (context, index) {
                final Pet pet = adoptedPets[index];
                return ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey, // Set the background color
                      shape: BoxShape.circle, // Makes the container circular
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        pet.imageUrl,
                        height: 50,
                        width: 50,
                        fit: BoxFit
                            .contain, // Ensures the image covers the circle
                      ),
                    ),
                  ),
                  title: Text(pet.name),
                  subtitle: Text(
                    'Adopted on ${DateFormat('MMMM dd, yyyy h:mm a').format(pet.adoptedDate!)} for \$${pet.price.toStringAsFixed(2)}',
                  ),
                );
              },
            );
          } else if (state is PetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Failed to load adoption history.'),
            );
          }
        },
      ),
    );
  }
}
