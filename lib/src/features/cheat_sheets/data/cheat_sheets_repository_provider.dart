import 'package:cheat_sheets/src/features/cheat_sheets/data/cheat_sheets_repository_impl.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/data/cheat_sheets_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheat_sheets_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CheatSheetsRepository cheatSheetsRepository(CheatSheetsRepositoryRef ref) {
  return CheatSheetsRepositoryImpl();
}
