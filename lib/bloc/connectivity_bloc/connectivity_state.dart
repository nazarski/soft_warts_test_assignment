part of 'connectivity_bloc.dart';

@immutable
class ConnectivityState {
  final bool hasConnection;

  const ConnectivityState({this.hasConnection = false});

  ConnectivityState copyWith({
    bool? hasConnection,
  }) {
    return ConnectivityState(
      hasConnection: hasConnection ?? this.hasConnection,
    );
  }
}
