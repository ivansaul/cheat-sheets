import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_repository_provider.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheatsheet_providers.g.dart';

@Riverpod(keepAlive: true)
class CheatsheetListController extends _$CheatsheetListController {
  @override
  Future<List<CheatsheetMeta>> build() async {
    return _init();
  }

  Future<List<CheatsheetMeta>> _init() async {
    final repository = ref.watch(cheatsheetRepositoryProvider);
    final result = await repository.list().run();
    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  }

  Future<void> onRetry() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }

  Future<void> onRefresh() async {
    ref.invalidateSelf();
    await future;
  }
}

@Riverpod()
class CheatsheetController extends _$CheatsheetController {
  @override
  Future<Cheatsheet> build(String byId) async {
    return _init();
  }

  Future<Cheatsheet> _init() async {
    final repository = ref.watch(cheatsheetRepositoryProvider);
    final result = await repository.get(byId).run();
    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  }
}
