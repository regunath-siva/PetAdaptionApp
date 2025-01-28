import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pet_bloc.dart';
import '../blocs/pet_event.dart';
import '../blocs/pet_state.dart';
import '../models/pet_model.dart';
import '../widgets/pet_adopt_dialog.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;

  const DetailsPage({super.key, required this.pet});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Details'),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          final updatedPet = (state as PetLoaded)
              .pets
              .firstWhere((p) => p.id == widget.pet.id);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Pet Image
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: InteractiveViewer(
                          child: Image.asset(
                            updatedPet.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'pet_image_${updatedPet.id}',
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode ? Colors.white54 : Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          updatedPet.imageUrl,
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // Pet Details Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      if (!isDarkMode)
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            updatedPet.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '\$${updatedPet.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        'A lovable companion waiting for a home.',
                        style: theme.textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 16),

                      // Additional Details (Breed, Gender, Age)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoTile(
                              icon: Icons.pets, label: 'Breed', value: "Breed"),
                          _buildInfoTile(
                              icon: Icons.male, label: 'Gender', value: 'Male'),
                          _buildInfoTile(
                              icon: Icons.calendar_today,
                              label: 'Age',
                              value: '${updatedPet.age} yrs'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: !updatedPet.isAdopted
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  PetAdoptDialog(petName: updatedPet.name),
                            ).then((_) {
                              context
                                  .read<PetBloc>()
                                  .add(AdoptPet(updatedPet.id, DateTime.now()));
                            });
                          }
                        : null,
                    child: Text(
                      updatedPet.isAdopted ? 'Adopted' : 'Adopt Now',
                      style: TextStyle(
                          color: updatedPet.isAdopted
                              ? Colors.white38
                              : Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget for Additional Details
  Widget _buildInfoTile(
      {required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
