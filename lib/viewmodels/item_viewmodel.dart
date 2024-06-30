import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class ItemViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<Recipe> _items = [];
  List<Recipe> get items => _items;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await apiService.fetchRecipes(query: 'chicken'); // Default query
    } catch (e) {
      _items = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<List<Recipe>> searchItems(String query) async {
    _isLoading = true;
    notifyListeners();

    List<Recipe> searchedItems = [];
    try {
      searchedItems = await apiService.fetchRecipes(query: query);
    } catch (e) {
      searchedItems = [];
    }

    _isLoading = false;
    notifyListeners();
    return searchedItems;
  }
}
