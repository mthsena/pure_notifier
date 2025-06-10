enum PureStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == PureStatus.initial;
  bool get isLoading => this == PureStatus.loading;
  bool get isSuccess => this == PureStatus.success;
  bool get isFailure => this == PureStatus.failure;
}
