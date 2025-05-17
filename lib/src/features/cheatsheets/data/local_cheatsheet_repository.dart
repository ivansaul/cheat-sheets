import 'dart:convert' show json;

import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_repository.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fpdart/fpdart.dart';

class LocalCheatsheetRepository implements CheatsheetRepository {
  List<Cheatsheet> _cheatsheets = [];
  List<CheatsheetMeta> _cheatsheetsMeta = [];
  List<dynamic> _rowData = [];

  @override
  TaskEither<AppException, List<CheatsheetMeta>> fetchCheatsheets() {
    return _loadCheatsheetsMeta();
  }

  @override
  TaskEither<AppException, Cheatsheet> fetchCheatsheet(String byId) {
    return _loadCheatsheets().flatMap(
      (cheatsheets) => TaskEither.tryCatch(
        () async => cheatsheets.firstWhere((element) => element.id == byId),
        (_, __) => const AppException.notFoundItem(),
      ),
    );
  }

  // private methods

  TaskEither<AppException, List<Cheatsheet>> _loadCheatsheets() {
    if (_cheatsheets.isNotEmpty) return TaskEither.of(_cheatsheets);

    return TaskEither.tryCatch(
      () async {
        final data = await _loadRawData();
        _cheatsheets = data.map((item) => Cheatsheet.fromJson(item)).toList();
        return _cheatsheets;
      },
      (_, __) => const AppException.decodingFailure(),
    );
  }

  TaskEither<AppException, List<CheatsheetMeta>> _loadCheatsheetsMeta() {
    if (_cheatsheetsMeta.isNotEmpty) return TaskEither.of(_cheatsheetsMeta);
    return TaskEither.tryCatch(
      () async {
        final data = await _loadRawData();
        _cheatsheetsMeta =
            data.map((item) => CheatsheetMeta.fromJson(item)).toList();
        return _cheatsheetsMeta;
      },
      (_, __) => const AppException.decodingFailure(),
    );
  }

  Future<List<dynamic>> _loadRawData() async {
    if (_rowData.isNotEmpty) return _rowData;
    final jsonString = await rootBundle.loadString('docs/data/data.json');
    _rowData = json.decode(jsonString) as List<dynamic>;
    return _rowData;
  }
}
