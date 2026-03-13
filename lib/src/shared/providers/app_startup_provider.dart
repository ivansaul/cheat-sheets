import 'package:cheat_sheets/src/theme/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  ref.onDispose(() {
    ref.invalidate(themeModeControllerProvider);
  });

  await Future.wait([
    ref.watch(themeModeControllerProvider.future),
  ]);
}
