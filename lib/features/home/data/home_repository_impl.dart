import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'package:cheat_sheets/features/home/data/home_repository.dart';
import 'package:cheat_sheets/features/home/domain/cheat_sheet_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<CheatSheetModel>> getCheatSheets() async {
    final jsonString = await rootBundle.loadString('docs/data/data.json');
    final cheatSheetsJson =await json.decode(jsonString) as List<dynamic>;

    List<CheatSheetModel> cheatSheets = [];

    for (final cheatSheet in cheatSheetsJson) {
      cheatSheets.add(CheatSheetModel.fromJson(cheatSheet));
    }

    return cheatSheets;
  }
}
