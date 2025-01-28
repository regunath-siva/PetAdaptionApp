import 'package:flutter/material.dart';

import '../models/pet_model.dart';
import '../routes.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.details,
          arguments: pet,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: isDarkMode ? 2.0 : 5.0,
        color: isDarkMode
            ? (pet.isAdopted ? Colors.grey[700] : Colors.grey[850])
            : (pet.isAdopted ? Colors.grey[200] : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Hero(
                  tag: 'pet_image_${pet.id}',
                  child: Image.asset(
                    pet.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pet.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            '${pet.age} years',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white54 : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '\u{20B9}${pet.price}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              pet.isAdopted ? Colors.grey : Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: pet.isAdopted
                            ? null
                            : () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.details,
                                  arguments: pet,
                                );
                              },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pet.isAdopted ? 'Already Adopted' : 'Adopt',
                              style: TextStyle(
                                color: pet.isAdopted
                                    ? Colors.white38
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!pet.isAdopted)
                              Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
