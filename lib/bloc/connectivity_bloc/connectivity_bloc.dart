import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';

part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final _connectivity = Connectivity();

  ConnectivityBloc() : super(const ConnectivityState()) {
    on<ListenToConnectionChanges>(_listenToConnectionChanges);
    on<EmitConnectionChange>(_emitConnectionChange);
  }
  void _emitConnectionChange(EmitConnectionChange event, Emitter emit) {
    emit(state.copyWith(hasConnection: event.hasConnection));
  }

  void _listenToConnectionChanges(_, Emitter emit) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.vpn:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
          add(EmitConnectionChange(true));
          break;
        default:
          add(EmitConnectionChange(false));
      }
    });
  }
}
