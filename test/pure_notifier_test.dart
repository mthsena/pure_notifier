import 'package:flutter_test/flutter_test.dart';
import 'package:pure_notifier/src/pure_failure.dart';
import 'package:pure_notifier/src/pure_notifier.dart';
import 'package:pure_notifier/src/pure_state.dart';
import 'package:pure_notifier/src/pure_status.dart';

final class Toggle extends PureNotifier<bool> {
  Toggle() : super(false);

  void toggle() {
    execute(() async => !state.value);
  }
}

void main() {
  late final Toggle toggle;

  setUpAll(() {
    toggle = Toggle();
  });

  group('[Pure State]:', () {
    test('should be initial', () {
      const initialValue = 0;
      final state = PureState.initial(initialValue);
      expect(state, isA<PureState<int>>());
      expect(state.status, isA<PureStatus>());
      expect(state.status, PureStatus.initial);
      expect(state.value, initialValue);
      expect(state.message, isEmpty);
    });

    test('should be loading', () {
      const initialValue = 0;
      final state = PureState.loading(initialValue);
      expect(state, isA<PureState<int>>());
      expect(state.status, isA<PureStatus>());
      expect(state.status, PureStatus.loading);
      expect(state.value, initialValue);
      expect(state.message, isEmpty);
    });

    test('should be failure', () {
      const initialValue = 0;
      final state = PureState.failure(initialValue);
      expect(state, isA<PureState<int>>());
      expect(state.status, isA<PureStatus>());
      expect(state.status, PureStatus.failure);
      expect(state.value, initialValue);
      expect(state.message, isEmpty);
    });

    test('should be success', () {
      const initialValue = 0;
      final state = PureState.success(initialValue);
      expect(state, isA<PureState<int>>());
      expect(state.status, isA<PureStatus>());
      expect(state.status, PureStatus.success);
      expect(state.value, initialValue);
      expect(state.message, isEmpty);
    });
  });

  group('[Pure Failure]:', () {
    test('should build successfully', () {
      const message = 'failure message';
      const failure = PureFailure(message);
      expect(failure, isA<PureFailure>());
      expect(failure.message, message);
      expect(failure.message, isNotEmpty);
    });
  });

  group('[Pure Notifier]:', () {
    test('should be a bool with value false', () {
      expect(toggle.state.value, isA<bool>());
      expect(toggle.state.value, false);
    });
    test('should be a bool with value true', () async {
      toggle.toggle();
      await Future.delayed(const Duration(seconds: 1));
      expect(toggle.state.value, isA<bool>());
      expect(toggle.state.value, true);
    });
  });
}
