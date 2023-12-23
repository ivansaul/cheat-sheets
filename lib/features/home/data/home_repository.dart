import 'package:cheat_sheets/features/home/domain/cheat_sheet_model.dart';

abstract class HomeRepository {
  Future<List<CheatSheetModel>> getCheatSheets();
}
