import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_data_source.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_data_source_exception.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_repository.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

final class CheatsheetRepositoryImpl implements CheatsheetRepository {
  CheatsheetRepositoryImpl({
    required CheatsheetDataSource dataSource,
  }) : _dataSource = dataSource;

  final CheatsheetDataSource _dataSource;

  @override
  TaskEither<AppException, List<CheatsheetMeta>> list() {
    return _dataSource.list().mapLeft((error) => error.toAppException());
  }

  @override
  TaskEither<AppException, Cheatsheet> get(String byId) {
    return _dataSource.get(byId).mapLeft((error) => error.toAppException());
  }
}
