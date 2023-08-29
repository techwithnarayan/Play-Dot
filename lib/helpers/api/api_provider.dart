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
      throw Exception(response.reasonPhrase);
    }
  }
}












// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:playdot/helpers/models/data_model.dart';


// class PostDetails {
//   final url = "https://techwithnarayan.github.io/api/posters.json";

//   Future<List<Movie>> fetchMoviesAndSeries() async {
//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = jsonDecode(response.body)['posts'];
//         return jsonData.map((json) => Movie.fromJson(json)).toList();
//       } else {
//         throw Exception("Failed to fetch data from API");
//       }
//     }  on http.ClientException catch (error) {
//       // Handle specific HTTP client exceptions (host lookup errors, etc.)
//       print("HTTP Client Exception: $error");
//       throw Exception("An error occurred while making an HTTP request");
//     }
//   }
// }



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:playdot/helpers/models/data_model.dart';

// class PostDetails {
//   final url = "https://techwithnarayan.github.io/api/posters.json";

//   Future<List<Movie>> fetchMoviesAndSeries() async {
//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = jsonDecode(response.body)['posts'];
//         return jsonData.map((json) => Movie.fromJson(json)).toList();
//       } else {
//         throw Exception("Failed to fetch data from API");
//       }
//     } catch (error) {
//       if (error is http.ClientException) {
//         // Handle specific HTTP client exceptions (host lookup errors, etc.)
//         print("HTTP Client Exception: $error");
//         throw Exception("An error occurred while making an HTTP request");
//       } else {
//         // Handle other errors
//         print("Other Error: $error");
//         rethrow; // Re-throw the error for higher-level handling
//       }
//     }
//   }
// }


// import 'package:dio/dio.dart';
// import 'package:playdot/helpers/models/data_model.dart';

// class PostDetails {
//   final url = "https://techwithnarayan.github.io/api/posters.json";
//   final Dio _dio = Dio();

//   Future<List<Movie>> fetchMoviesAndSeries() async {
//     try {
//       final response = await _dio.get(url);

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = response.data['posts'];
//         return jsonData.map((json) => Movie.fromJson(json)).toList();
//       } else {
//         throw Exception("Failed to fetch data from API");
//       }
//     } on DioError catch (error) {
//       if (error.type == DioExceptionType.connectionTimeout ||
//           error.type == DioExceptionType.sendTimeout ||
//           error.type == DioExceptionType.receiveTimeout ||
//           error.type == DioExceptionType.unknown||
//           error.type == DioExceptionType.badResponse
//           ) {
//         // Handle network errors
//         print("Network error: ${error.message}");
//         throw Exception("Failed to make an HTTP request");
//       } else {
//         // Handle other Dio errors
//         print("An error occurred: $error");
//         throw Exception("An error occurred while making an HTTP request");
//       }
//     }
//   }
// }