import '../models/recipe.dart';
import '../services/api_service.dart';

class ItemController {
  final ApiService apiService = ApiService();

  Future<List<Recipe>> fetchItems() async {
    return await apiService.fetchRecipes(query: 'chicken');
  }

  Future<List<Recipe>> searchItems(String query) async {
    return await apiService.fetchRecipes(query: query);
  }
}
