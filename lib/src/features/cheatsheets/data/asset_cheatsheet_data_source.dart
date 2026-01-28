import 'dart:convert';

import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_data_source.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_data_source_exception.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fpdart/fpdart.dart';

final class AssetCheatsheetDataSource implements CheatsheetDataSource {
  List<Cheatsheet> _cheatsheets = [];
  List<CheatsheetMeta> _cheatsheetsMeta = [];
  List<dynamic> _rawData = [];

  @override
  TaskEither<CheatsheetDataSourceException, Cheatsheet> get(
    String byId,
  ) {
    return _loadCheatsheets().flatMap(
      (cheatsheets) => TaskEither.tryCatch(
        () async => cheatsheets.firstWhere((element) => element.id == byId),
        (error, st) => CheatsheetDataSourceException.notFound(
          error: error,
          stackTrace: st,
        ),
      ),
    );
  }

  @override
  TaskEither<CheatsheetDataSourceException, List<CheatsheetMeta>> list() {
    return _loadCheatsheetsMeta();
  }

  // private methods

  TaskEither<CheatsheetDataSourceException, List<Cheatsheet>>
      _loadCheatsheets() {
    if (_cheatsheets.isNotEmpty) return TaskEither.of(_cheatsheets);

    return TaskEither.tryCatch(
      () async {
        final data = await _loadRawData();
        _cheatsheets = data.map((item) => Cheatsheet.fromJson(item)).toList();
        return _cheatsheets;
      },
      (error, st) => CheatsheetDataSourceException.parsing(
        error: error,
        stackTrace: st,
      ),
    );
  }

  TaskEither<CheatsheetDataSourceException, List<CheatsheetMeta>>
      _loadCheatsheetsMeta() {
    if (_cheatsheetsMeta.isNotEmpty) return TaskEither.of(_cheatsheetsMeta);
    return TaskEither.tryCatch(
      () async {
        final data = await _loadRawData();
        _cheatsheetsMeta = data
            .map((item) => CheatsheetMeta.fromJson(item))
            .sorted((a, b) =>
                a.title.toLowerCase().compareTo(b.title.toLowerCase()));

        return _cheatsheetsMeta;
      },
      (error, st) => CheatsheetDataSourceException.parsing(
        error: error,
        stackTrace: st,
      ),
    );
  }

  Future<List<dynamic>> _loadRawData() async {
    if (_rawData.isNotEmpty) return _rawData;
    final jsonString = await rootBundle.loadString('docs/data/data.json');
    _rawData = json.decode(jsonString) as List<dynamic>;
    return _rawData;
  }
}
