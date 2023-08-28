import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:playdot/helpers/models/data_model.dart';



class PostDetails {
  final url = "https://techwithnarayan.github.io/api/posters.json";

  Future<List<Movie>> fetchMoviesAndSeries() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['posts'];
      return jsonData.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch data from API");
    }
  }
}