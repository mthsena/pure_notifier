import 'package:flutter/widgets.dart';

import 'pure_notifier.dart';

final class PureBuilder<T extends PureNotifier> extends StatefulWidget {
  const PureBuilder({
    super.key,
    required this.notifier,
    required this.builder,
  });

  final T notifier;
  final Widget Function(BuildContext context, Widget? child) builder;

  @override
  State<PureBuilder> createState() => _PureBuilderState<T>();
}

final class _PureBuilderState<T extends PureNotifier> extends State<PureBuilder<T>> {
  @override
  void dispose() {
    widget.notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.notifier,
      builder: widget.builder,
    );
  }
}
