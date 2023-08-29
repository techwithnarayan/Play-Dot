import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playdot/blocs/bloc/apidata_bloc.dart';
import 'package:playdot/blocs/bloc/internet_bloc.dart';
import 'package:playdot/helpers/api/api_provider.dart';

import 'package:playdot/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        BlocProvider(
          create: (context) => ApiDataBloc(PostDetails()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        // home: GridTilePage(),

        theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(),
            bodyMedium: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

/*

// api_bloc.dart
import 'dart:async';
import 'dart:convert';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
//import 'package:playdot/blocs/bloc/internet_bloc.dart';
import 'package:playdot/helpers/models/data_model.dart';

// Events
abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends ApiEvent {}

// States
abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiInitialState extends ApiState {}

class ApiLoadingState extends ApiState {}

class ApiLoadedState extends ApiState {
  final List<String> data;

  ApiLoadedState(this.data);

  @override
  List<Object> get props => [data];
}

class ApiErrorState extends ApiState {
  final String error;

  ApiErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// api_bloc.dart (continued)
class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final http.Client httpClient;
  final Connectivity connectivity;

  ApiBloc({required this.httpClient, required this.connectivity})
      : super(ApiInitialState());

  @override
  Stream<ApiState> mapEventToState(ApiEvent event) async* {
    if (event is FetchDataEvent) {
      yield ApiLoadingState();

      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        yield ApiErrorState("No internet connection");
        return;
      }

      try {
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
      } catch (error) {
        yield ApiErrorState("An error occurred while making an API request");
      }
    }
  }
}

// main.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc API Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ApiBloc>(
            create: (context) =>
                ApiBloc(httpClient: http.Client(), connectivity: Connectivity())
                  ..add(FetchDataEvent()),
          ),
          
        ],
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bloc API Example')),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiInitialState || state is ApiLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ApiErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is ApiLoadedState) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.data[index]),
                );
              },
            );
          } else {
            return Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}
*/