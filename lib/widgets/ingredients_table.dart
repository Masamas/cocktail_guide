import 'package:cocktail_guide/models/cocktail.dart';
import 'package:flutter/material.dart';

class IngredientsTable extends StatelessWidget {
  final Cocktail cocktail;

  const IngredientsTable({Key key, this.cocktail}) : super(key: key);

  TableRow _buildIngredientsTableRow(MapEntry entry) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(entry.key ?? ''),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(entry.value ?? ''),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: cocktail.ingredientsWithMeasurements.entries.map(_buildIngredientsTableRow).toList(),
    );
  }
}
