import 'dart:convert' show json;

import 'package:cheat_sheets/src/features/cheat_sheets/data/cheat_sheets_repository.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/domain/cheat_sheet.dart';
import 'package:flutter/services.dart' show rootBundle;

class CheatSheetsRepositoryImpl implements CheatSheetsRepository {
  @override
  Future<List<CheatSheet>> getCheatSheets() async {
    final jsonString = await rootBundle.loadString('docs/data/data.json');
    final cheatSheetsJson = await json.decode(jsonString) as List<dynamic>;

    List<CheatSheet> cheatSheets = [];

    for (final cheatSheet in cheatSheetsJson) {
      cheatSheets.add(CheatSheet.fromJson(cheatSheet));
    }

    return cheatSheets;
  }
}
