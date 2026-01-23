import 'package:flutter/foundation.dart';

import 'pure_status.dart';

base class PureNotifier<T> extends ChangeNotifier {
  PureNotifier(
    this._value,
  );

  T _value;
  PureStatus _status = PureStatus.initial;
  Exception? _failure;
  T get value => _value;
  Exception get failure => _failure!;
  bool get isInitial => _status.isInitial;
  bool get isLoading => _status.isLoading;
  bool get isSuccess => _status.isSuccess;
  bool get isFailure => _status.isFailure;

  void _update(PureStatus newStatus, T newValue, [Exception? failure]) {
    if (newStatus == _status && newValue == _value) return;
    _status = newStatus;
    _failure = failure;
    _value = newValue;
    notifyListeners();
  }

  void updateSync(T newValue) {
    _update(PureStatus.success, newValue);
  }

  void updateAsync(Future<T> Function() action) async {
    try {
      _update(PureStatus.loading, _value);
      _update(PureStatus.success, await action());
    } on Exception catch (e) {
      _update(PureStatus.failure, _value, e);
    }
  }
}
