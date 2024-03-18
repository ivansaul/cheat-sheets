import 'package:cheat_sheets/src/features/cheat_sheets/domain/cheat_sheet.dart';

abstract class CheatSheetsRepository {
  Future<List<CheatSheet>> getCheatSheets();
}
