import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_data_source_exception.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:fpdart/fpdart.dart';

abstract class CheatsheetDataSource {
  TaskEither<CheatsheetDataSourceException, List<CheatsheetMeta>> list();
  TaskEither<CheatsheetDataSourceException, Cheatsheet> get(String byId);
}
