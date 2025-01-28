import 'package:flutter/material.dart';

class PaginatedRow extends StatelessWidget {
  final int page;
  final int pageSize;
  final bool isDarkMode;
  final void Function() onPrevious;
  final void Function() onNext;
  final int totalItems;

  const PaginatedRow({
    super.key,
    required this.page,
    required this.pageSize,
    required this.isDarkMode,
    required this.onPrevious,
    required this.onNext,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    final isPreviousDisabled = page <= 1;
    final isNextDisabled = (page * pageSize) >= totalItems;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black54 : Colors.grey[300]!,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: isPreviousDisabled ? null : onPrevious,
              style: ElevatedButton.styleFrom(
                backgroundColor: isPreviousDisabled
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Previous'),
            ),
            Text(
              'Page $page',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: isNextDisabled ? null : onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: isNextDisabled
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
