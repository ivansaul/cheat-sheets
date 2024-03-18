import 'package:cheat_sheets/src/features/cheat_sheets/data/cheat_sheets_repository_provider.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/domain/cheat_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheat_sheets_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<CheatSheet>> cheatSheets(CheatSheetsRef ref) async {
  final cheatSheets =
      await ref.read(cheatSheetsRepositoryProvider).getCheatSheets();

  return cheatSheets;
}
