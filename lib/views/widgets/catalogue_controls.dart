import 'package:flutter/material.dart';
import '../../models/book_status.dart';

class CatalogueControls extends StatelessWidget {
  const CatalogueControls({
    super.key,
    required this.selected,
    required this.onSearch,
    required this.onFilter,
  });

  final BookStatus? selected;
  final ValueChanged<String> onSearch;
  final ValueChanged<BookStatus?> onFilter;

  Widget _chip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onSearch,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search title or author',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            _chip('All', selected == null, () => onFilter(null)),
            for (final s in BookStatus.values)
              _chip(s.label, selected == s, () => onFilter(s)),
          ]),
        ),
      ],
    );
  }
}
