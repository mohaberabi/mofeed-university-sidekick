mixin CubitEmiiter {
  void emitDone();

  void emitError(String error, {StackTrace? st});

  void emitLoading();

  void emitInitial();
}
