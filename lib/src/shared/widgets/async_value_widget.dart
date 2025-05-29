import 'package:cheat_sheets/src/shared/screens/error_screen.dart';
import 'package:cheat_sheets/src/shared/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.data,
    this.onRetry,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T value) data;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      loading: () => const LoadingView(),
      error: (e, st) => ErrorView(
        error: e,
        stackTrace: st,
        onRetry: onRetry,
      ),
      data: data,
    );
  }
}

class AsyncValueSliverWidget<T> extends StatelessWidget {
  const AsyncValueSliverWidget({
    super.key,
    required this.asyncValue,
    required this.data,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T value) data;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      loading: () => const SliverToBoxAdapter(
        child: LoadingView(),
      ),
      error: (e, st) => SliverToBoxAdapter(
        child: ErrorView(error: e, stackTrace: st),
      ),
      data: data,
    );
  }
}
