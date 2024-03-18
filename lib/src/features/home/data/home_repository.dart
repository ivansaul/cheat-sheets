import 'package:cheat_sheets/src/features/home/domain/cheat_sheet_model.dart';

abstract class HomeRepository {
  Future<List<CheatSheetModel>> getCheatSheets();
}
