part of 'internet_bloc.dart';

sealed class InternetState {}

final class InternetInitial extends InternetState {} 

class InternetLostState extends InternetState{}

class InternetGainState extends InternetState{}