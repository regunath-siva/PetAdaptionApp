import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.onChanged,
  });

  final dynamic onChanged;

  @override
  Widget build(BuildContext context) {
    //Needs to move this to util file to use multiple places
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return TextField(
      autofocus: false,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search pets by name/price/age...',
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
    );
  }
}
