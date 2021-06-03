import 'dart:convert';
import 'dart:io';

import 'package:food2fork/model/Recipe.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<List<Recipe>> getRecipes() async {
    var response = await http.get(
      Uri.parse('https://food2fork.ca/api/recipe/search/?page=1&query='),
      headers: {
        HttpHeaders.authorizationHeader:
            'Token 9c8b06d329136da358c2d00e76946b0111ce2c48',
      },
    );

    if(response.statusCode == 200){
      final List<Recipe> recipeList = [];
      final responseJson = jsonDecode(response.body);
      for (Map<String, dynamic> recipe in responseJson['results']) {
        recipeList.add(
          Recipe.fromJson(recipe),
        );
      }
      return recipeList;
    } else {
      throw Exception('sss');
    }

  }
}
