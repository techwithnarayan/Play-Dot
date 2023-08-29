// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// part 'internet_event.dart';
// part 'internet_state.dart';

// class InternetBloc extends Bloc<InternetEvent, InternetState> {
//   InternetBloc() : super(InternetInitial()) {
//     on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
//     on<InternetGainEvent>((event, emit) => emit(InternetGainState()));
// // Connectivity connectivity = Connectivity();
// //     StreamSubscription? connectivitySubscription;

// //     connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
// //       if (result == ConnectivityResult.none || result == ConnectivityResult.disconnected) {
// //         add(InternetLostEvent());
// //       } else {
// //         _checkInternetConnection();
// //       }
// //     });
// //   }

// //   Future<void> _checkInternetConnection() async {
// //     if (await _connectionChecker.hasConnection) {
// //       add(InternetGainEvent());
// //     } else {
// //       add(InternetLostEvent());
// //     }
// //   }

//   InternetConnectionChecker connectionChecker = InternetConnectionChecker();
//     Connectivity connectivity = Connectivity();
//     StreamSubscription? connectivitySubscription;
//     connectivitySubscription =
//         connectivity.onConnectivityChanged.listen((result,) async{
//       if (result == ConnectivityResult.none || result ==  InternetConnectionStatus.disconnected) {
//         add(InternetLostEvent());
//       } else {
//        checkInternetConnection();
//       }
//     });

//    Future<void> checkInternetConnection() async {
//     if (await connectionChecker.hasConnection) {
//       add(InternetGainEvent());
//     } else {
//       add(InternetLostEvent());
//     }
//   }

//     Future<void> close() {
//       connectivitySubscription?.cancel();
//       return super.close();
//     }
//   }
// }

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitial()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainEvent>((event, emit) => emit(InternetGainState()));
    connectivitySubscription =
        _connectionChecker.onStatusChange.listen((status) async {
      if (status == InternetConnectionStatus.connected) {
        add(InternetGainEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
