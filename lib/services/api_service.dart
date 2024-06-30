import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe.dart';

class ApiService {
  final String baseUrl = 'https://api.edamam.com';
  final String appId = '6fef616c';
  final String appKey = 'b2428c1e6dd9b0d1f67bb9e290f18010';

  Future<List<Recipe>> fetchRecipes({required String query}) async {
    final url = Uri.parse('$baseUrl/api/recipes/v2?type=public&q=$query&app_id=$appId&app_key=$appKey');
    print('Request URL: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response: $data');
      if (data['hits'] != null && data['hits'].isNotEmpty) {
        final List<Recipe> recipes = (data['hits'] as List).map((hit) => Recipe.fromJson(hit['recipe'])).toList();
        return recipes;
      } else {
        print('No recipes found in response');
        throw Exception('No recipes found');
      }
    } else {
      print('Failed to load recipes: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load recipes');
    }
  }

  Future<Recipe> fetchRandomRecipe() async {
    final url = Uri.parse('$baseUrl?q=&app_id=$appId&app_key=$appKey');
    print('Request URL: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API response: $data');
      if (data['hits'] != null && data['hits'].isNotEmpty) {
        final Recipe recipe = Recipe.fromJson(data['hits'][0]['recipe']);
        return recipe;
      } else {
        print('No recipes found in response');
        throw Exception('No recipes found');
      }
    } else {
      print('Failed to load recipes: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load recipes');
    }
  }
}

