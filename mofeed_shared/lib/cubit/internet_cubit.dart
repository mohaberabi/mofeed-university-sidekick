import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../data/network_info.dart';

enum ConnectionStatus { connected, disconnected }

class InternetCubit extends Cubit<ConnectionStatus> {
  final NetWorkInfo _connection;

  StreamSubscription? _connectivitySubscription;

  InternetCubit({
    required NetWorkInfo connection,
  })  : _connection = connection,
        super(ConnectionStatus.disconnected);

  void onConnectivityChanged() {
    _connectivitySubscription =
        _connection.listenToNetWork().handleError((e, st) {
      addError(e, st);
    }).listen((event) {
      if (event == InternetConnectionStatus.disconnected) {
        emit(ConnectionStatus.disconnected);
      } else {
        emit(ConnectionStatus.connected);
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
