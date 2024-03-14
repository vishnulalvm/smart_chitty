import 'package:flutter/material.dart';

class FillterChip extends StatefulWidget {
  const FillterChip({super.key});

  @override
  State<FillterChip> createState() => _FillterChipState();
}

class _FillterChipState extends State<FillterChip> {
  final List<String> _filters = [
    'Scheme 1',
    'Scheme 2',
    'Scheme 3',
    'Scheme 1',
    'Scheme 2',
    'Scheme 3'
  ];
  final List<String> _selectedFilters = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final filter in _filters)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FilterChip(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                label: Text(filter),
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      _selectedFilters.add(filter);
                    } else {
                      _selectedFilters.remove(filter);
                    }
                  });
                },
                selected: _selectedFilters.contains(filter),
              ),
            ),
        ],
      ),
    );
  }
}
