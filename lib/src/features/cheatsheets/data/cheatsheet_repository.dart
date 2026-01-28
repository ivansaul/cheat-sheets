import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/shared/exceptions/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

abstract class CheatsheetRepository {
  TaskEither<AppException, List<CheatsheetMeta>> list();
  TaskEither<AppException, Cheatsheet> get(String byId);
}
