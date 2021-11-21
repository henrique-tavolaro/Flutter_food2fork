import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food2fork/model/Recipe.dart';
import 'package:http/http.dart' as http;

class NetworkService {

  final Dio dio;

  NetworkService(this.dio){
    dio.options.baseUrl = "https://food2fork.ca/api/recipe/search";
    dio.options.headers['Authorization'] = 'Token 9c8b06d329136da358c2d00e76946b0111ce2c48';
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler){
        print('base url ${options.baseUrl}');
        print('path url ${options.path}');
        print('geaders url ${options.headers}');
        return handler.next(options);
      },
      onResponse: (response, handler){
        print('response ${response.statusCode}');
        return handler.next(response);
      },
      onError: (DioError e, handler){
       print('ERROR ${e.response?.statusCode}');
       return handler.next(e);
      }
    ));
  }

  Future<List<Recipe>> getRecipes(String query, int page) async {
    var response = await dio.get('/?page=$page&query=$query');
    // var response = await http.get(
    //   Uri.parse('https://food2fork.ca/api/recipe/search/?page=$page&query=$query'),
    //   headers: {
    //     HttpHeaders.authorizationHeader:
    //         'Token 9c8b06d329136da358c2d00e76946b0111ce2c48',
    //   },
    // );
    //
    print('RESPONSE: ${response.data}');
    if(response.statusCode == 200){
      final List<Recipe> recipeList = [];
      // final responseJson = jsonDecode(response.data['results']);
      for (Map<String, dynamic> recipe in response.data['results']) {
        recipeList.add(
          Recipe.fromJson(recipe),
        );
      }
      print('recipe: $recipeList');
      return recipeList;
    } else {
      print('error sss');
      throw Exception('sss');
    }
  }
}
