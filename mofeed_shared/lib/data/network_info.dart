import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo {
  Future<bool> get isConnected;

  Stream<InternetConnectionStatus> listenToNetWork();
}

class NetWorkInfoImpl implements NetWorkInfo {
  final InternetConnectionChecker connectionChecker;

  NetWorkInfoImpl({required this.connectionChecker});

  Stream<InternetConnectionStatus> listenToNetWork() =>
      connectionChecker.onStatusChange;

  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;
}
