import 'package:flutter/foundation.dart';

import 'pure_failure.dart';
import 'pure_state.dart';

base class PureNotifier<T> extends ChangeNotifier {
  PureNotifier(
    this._initialValue,
  );

  final T _initialValue;
  late PureState<T> _state = PureState<T>.initial(_initialValue);
  PureState<T> get state => _state;

  void _update(PureState<T> newState) {
    _state = newState;
    notifyListeners();
  }

  void execute(Future<T> Function() action) async {
    try {
      _update(PureState<T>.loading(_state.value));
      _update(PureState<T>.success(await action()));
    } on PureFailure catch (e) {
      _update(PureState<T>.failure(_state.value, e.message));
    }
  }
}
