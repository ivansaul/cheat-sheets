import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_connection_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<InternetStatus> internetConnection(Ref ref) {
  return InternetConnection().onStatusChange;
}
