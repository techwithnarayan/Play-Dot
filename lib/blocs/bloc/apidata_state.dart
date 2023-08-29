part of 'apidata_bloc.dart';

abstract class ApiDataState {}

class ApidataLoadingState extends ApiDataState {
  List<Object?> get props => [];
}

class ApidataLoadedState extends ApiDataState {
  final List<Movie> movies;
  ApidataLoadedState(this.movies);
  List<Object?> get props => [movies];
}

class ApidataErrorState extends ApiDataState {
  final String error;
  ApidataErrorState(this.error);
  List<Object?> get props => [error];
}
