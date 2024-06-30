import 'package:flutter/material.dart';
import '../models/recipe.dart';

class ItemDetailPage extends StatelessWidget {
  final Recipe recipe;

  ItemDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.label),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.image),
            SizedBox(height: 8),
            Text(
              recipe.label,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Source: ${recipe.source}',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              'Calories: ${recipe.calories.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var ingredient in recipe.ingredientLines)
              Text(
                ingredient,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
