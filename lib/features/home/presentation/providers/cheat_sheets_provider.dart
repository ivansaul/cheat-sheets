import 'package:cheat_sheets/features/home/data/home_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cheat_sheets/features/home/domain/cheat_sheet_model.dart';

part 'cheat_sheets_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<CheatSheetModel>> cheatSheets(CheatSheetsRef ref) async {
  final cheatSheets = await ref.read(homeRepositoryProvider).getCheatSheets();

  return cheatSheets;
}
