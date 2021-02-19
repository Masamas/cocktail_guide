import 'dart:convert';

import 'package:cocktail_guide/models/cocktail.dart';
import 'package:http/http.dart' as http;

class CocktailService {
  final String url = 'https://www.thecocktaildb.com/api/json/v1/1';

  Future<List<Cocktail>> getCocktailsByName(String name) async {
    final response = await http.get(url + '/search.php?s=$name');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body)['drinks'];
      if (decoded != null) {
        return decoded.map<Cocktail>((json) => Cocktail.fromJson(json)).toList();
      } else {
        return List<Cocktail>();
      }
    } else {
      throw Exception('failed to load cocktails');
    }
  }
}
