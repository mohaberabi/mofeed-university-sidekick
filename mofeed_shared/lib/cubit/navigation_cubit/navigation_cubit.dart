import 'package:bloc/bloc.dart';

abstract class NavState {
  const NavState();
}

class NavInitState extends NavState {
  const NavInitState();
}

class GoHomeScreen extends NavState {
  const GoHomeScreen();
}

class GoOnBoarding extends NavState {
  const GoOnBoarding();
}

class NoNetwork extends NavState {
  const NoNetwork();
}

class GoToAuth extends NavState {
  const GoToAuth();
}

class Pop extends NavState {
  const Pop();
}

class GoAddSakan extends NavState {
  GoAddSakan();
}

class GoCompleteMetaData extends NavState {
  final String message;

  GoCompleteMetaData(this.message);
}
