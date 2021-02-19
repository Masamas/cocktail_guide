import 'package:cocktail_guide/models/cocktail.dart';
import 'package:cocktail_guide/widgets/ingredients_table.dart';
import 'package:flutter/material.dart';

class CocktailDetail extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetail({this.cocktail});

  Widget _buildTags() {
    return Wrap(
      children: cocktail.tags
          .map<Widget>((tag) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Chip(label: Text(tag)),
              ))
          .toList(),
    );
  }

  Widget _buildIngredients() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredients:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IngredientsTable(cocktail: cocktail),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(cocktail.instructions),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cocktail.name),
      ),
      body: ListView(
        children: [
          Hero(
            tag: cocktail.id,
            child: Image.network(cocktail.thumbnailUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Visibility(
                    visible: cocktail.altName.isNotEmpty, child: _buildInfoRow('Alternate name', cocktail.altName)),
                _buildInfoRow('Category', cocktail.category),
                _buildInfoRow('Alcoholic', cocktail.alcoholic),
                _buildInfoRow('Glass', cocktail.glass),
                _buildIngredients(),
                _buildInstructions(),
                _buildTags(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
