import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pet_bloc.dart';
import '../blocs/pet_event.dart';
import '../blocs/pet_state.dart';
import '../routes.dart';
import '../widgets/paginated_row.dart';
import '../widgets/pet_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  int _page = 1;
  static const int _pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Adoption App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<PetBloc>().add(FilterPets(value));
              },
              decoration: InputDecoration(
                hintText: 'Search pets by name...',
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.white54 : Colors.black54,
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          if (state is PetLoaded) {
            final paginatedPets = state.pets
                .skip((_page - 1) * _pageSize)
                .take(_pageSize)
                .toList();

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: paginatedPets.length,
                    itemBuilder: (context, index) {
                      final pet = paginatedPets[index];
                      return PetCard(pet: pet);
                    },
                  ),
                ),
                if (state.pets.length > _pageSize)
                  PaginatedRow(
                    page: _page,
                    pageSize: _pageSize,
                    isDarkMode: isDarkMode,
                    onPrevious: () {
                      setState(() {
                        _page--;
                      });
                    },
                    onNext: () {
                      setState(() {
                        _page++;
                      });
                    },
                    totalItems: state.pets.length,
                  ),
              ],
            );
          } else if (state is PetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Text(
                'Failed to load pets.',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
