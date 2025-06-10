import 'pure_status.dart';

final class PureState<T> {
  const PureState._({
    required this.status,
    required this.message,
    required this.value,
  });

  final PureStatus status;
  final String message;
  final T value;

  factory PureState.initial(T value, [String message = '']) {
    return PureState._(
      status: PureStatus.initial,
      message: message,
      value: value,
    );
  }

  factory PureState.loading(T value, [String message = '']) {
    return PureState._(
      status: PureStatus.loading,
      message: message,
      value: value,
    );
  }

  factory PureState.failure(T value, [String message = '']) {
    return PureState._(
      status: PureStatus.failure,
      message: message,
      value: value,
    );
  }

  factory PureState.success(T value, [String message = '']) {
    return PureState._(
      status: PureStatus.success,
      message: message,
      value: value,
    );
  }
}
