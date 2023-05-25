part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class ListenToConnectionChanges extends ConnectivityEvent {}

class EmitConnectionChange extends ConnectivityEvent {
  final bool hasConnection;

  EmitConnectionChange(this.hasConnection);
}
