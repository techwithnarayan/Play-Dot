part of 'apidata_bloc.dart';

abstract class ApiDataEvent {}

class ApiDataFetchEvent extends ApiDataEvent {
  List<Object?> get props => [];
}
