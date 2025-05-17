import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_repository_provider.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheatsheet_providers.g.dart';

@Riverpod(keepAlive: true)
class CheatsheetsController extends _$CheatsheetsController {
  @override
  Future<List<CheatsheetMeta>> build() async {
    return _init();
  }

  Future<List<CheatsheetMeta>> _init() async {
    final repository = ref.watch(cheatsheetRepositoryProvider);
    final result = await repository.fetchCheatsheets().run();

    return result.fold(
      (l) => throw l.message(),
      (r) => r,
    );
  }
}

@Riverpod(keepAlive: true)
class CheatsheetController extends _$CheatsheetController {
  @override
  Future<Cheatsheet> build(String byId) async {
    return _init();
  }

  Future<Cheatsheet> _init() async {
    final repository = ref.watch(cheatsheetRepositoryProvider);
    final result = await repository.fetchCheatsheet(byId).run();

    return result.fold(
      (l) => throw l.message(),
      (r) => r,
    );
  }
}
