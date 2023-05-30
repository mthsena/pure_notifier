import 'package:flutter/foundation.dart';

import 'pure_state.dart';

final class PureFailure implements Exception {
  const PureFailure(
    this.message,
  );

  final String message;
}

abstract base class PureNotifier<T> extends ChangeNotifier {
  PureNotifier(
    this._initialValue,
  );

  final T _initialValue;
  late PureState<T> _state = PureState<T>.initial(_initialValue);
  PureState<T> get state => _state;

  void _notify(PureState<T> newState) {
    _state = newState;
    notifyListeners();
  }

  void notify(Future<T> Function() callBack) async {
    try {
      _notify(PureState<T>.loading(_state.value));
      _notify(PureState<T>.success(await callBack()));
    } on PureFailure catch (e) {
      _notify(PureState<T>.failure(_state.value, e.message));
    }
  }
}
