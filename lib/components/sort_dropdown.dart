import 'package:flutter/material.dart';
import '../utils/sort_type.dart';

class SortDropdown extends StatelessWidget {
  final SortType currentSortType;
  final ValueChanged<SortType> onSortChanged;

  const SortDropdown({
    super.key,
    required this.currentSortType,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<SortType>(
        value: currentSortType,
        dropdownColor: const Color(0xFF1E1E1E),
        underline: const SizedBox(),
        icon: const Icon(Icons.sort, color: Colors.white70, size: 20),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
        items: const [
          DropdownMenuItem(
            value: SortType.rating,
            child: Row(
              children: [
                Icon(Icons.star, size: 18, color: Colors.amber),
                SizedBox(width: 8),
                Text('Rating'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: SortType.year,
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                SizedBox(width: 8),
                Text('Year'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: SortType.title,
            child: Row(
              children: [
                Icon(Icons.title, size: 18, color: Colors.green),
                SizedBox(width: 8),
                Text('Title'),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            onSortChanged(value);
          }
        },
      ),
    );
  }
}
