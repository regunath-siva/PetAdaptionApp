import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pet_bloc.dart';
import '../blocs/pet_event.dart';
import '../blocs/pet_state.dart';
import '../routes.dart';
import '../widgets/paginated_row.dart';
import '../widgets/pet_card.dart';
import '../widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 1;
  static const int _pageSize = 10;

  @override
  Widget build(BuildContext context) {
    //Needs to move this isDark mode to util file to use multiple places
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Adoption Assessment Task'),
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
            child: SearchWidget(
              key: Key('search_widget'),
              onChanged: (value) {
                context.read<PetBloc>().add(FilterPets(value));
              },
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
                    key: Key('pet_grid'),
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
                      return PetCard(
                        pet: pet,
                        key: Key(pet.id),
                      );
                    },
                  ),
                ),
                if (state.pets.length > _pageSize)
                  PaginatedRow(
                    key: Key('paginated_row'),
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
                key: Key('failed_text'),
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
