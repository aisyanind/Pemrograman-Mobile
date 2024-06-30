import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchRecipes(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _recipes = await apiService.fetchRecipes(query: query);
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }
}
