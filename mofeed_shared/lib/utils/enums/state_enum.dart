import 'package:flutter/material.dart';

enum CubitState {
  initial,
  loading,
  error,
  done;

  bool get isInitial => this == CubitState.initial;

  bool get isLoading => this == CubitState.loading;

  bool get isDone => this == CubitState.done;

  bool get isError => this == CubitState.error;

  Widget loadingOrElse({required Widget whenLoading, required Widget orElse}) {
    if (isLoading) {
      return whenLoading;
    } else {
      return orElse;
    }
  }

  void when({
    required void Function() error,
    required void Function() done,
    required void Function() loading,
    void Function()? initial,
  }) {
    switch (this) {
      case CubitState.initial:
        if (initial != null) {
          initial();
        }
        break;
      case CubitState.loading:
        loading();
        break;
      case CubitState.done:
        done();
        break;
      case CubitState.error:
        error();
        break;
    }
  }

  Widget child({
    required Widget doneChild,
    required Widget errorChild,
    required Widget loadingChild,
    Widget? initialChild,
  }) {
    switch (this) {
      case CubitState.initial:
        return initialChild ?? const SizedBox();
      case CubitState.loading:
        return loadingChild;
      case CubitState.done:
        return doneChild;
      case CubitState.error:
        return errorChild;
    }
  }

  Widget buildWhen({
    required Widget Function() onLoading,
    required Widget Function() onError,
    required Widget Function() onDone,
    Widget Function()? onInit,
  }) {
    switch (this) {
      case CubitState.initial:
        if (onInit != null) onInit();
        return const SizedBox();
      case CubitState.loading:
        return onLoading();
      case CubitState.error:
        return onError();
      case CubitState.done:
        return onDone();
    }
  }
}

extension CubitStaterParser on String {
  CubitState get toCubitStater {
    switch (this) {
      case "loading":
        return CubitState.loading;
      case "error":
        return CubitState.error;
      case "done":
        return CubitState.done;
      default:
        return CubitState.initial;
    }
  }
}
