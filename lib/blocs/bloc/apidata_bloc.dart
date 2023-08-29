import 'dart:core';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bloc/bloc.dart';
import 'package:playdot/helpers/api/api_provider.dart';

import 'package:playdot/helpers/models/data_model.dart';

part 'apidata_event.dart';
part 'apidata_state.dart';

class ApiDataBloc extends Bloc<ApiDataEvent, ApiDataState> {
  final PostDetails _postDetails;
  //final HttpClient httpClient;
  ApiDataBloc(this._postDetails,) : super(ApidataLoadingState()) {
    on<ApiDataFetchEvent>((event, emit) async {
      emit(ApidataLoadingState());
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        
         emit(ApidataErrorState("error"));
      }

      try {
        final movies = await _postDetails.fetchMoviesAndSeries();
        emit(ApidataLoadedState(movies));
      } catch (e) {
        emit(ApidataErrorState(e.toString()));
      }
    });
  }
}
