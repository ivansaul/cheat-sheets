import 'package:cheat_sheets/src/features/home/data/home_repository_provider.dart';
import 'package:cheat_sheets/src/features/home/domain/cheat_sheet_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheat_sheets_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<CheatSheetModel>> cheatSheets(CheatSheetsRef ref) async {
  final cheatSheets = await ref.read(homeRepositoryProvider).getCheatSheets();

  return cheatSheets;
}
