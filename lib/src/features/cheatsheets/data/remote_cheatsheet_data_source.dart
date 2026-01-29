import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_data_source.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_data_source_exception.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_resources.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';
import 'package:fpdart/fpdart.dart';

final class RemoteCheatsheetDataSource implements CheatsheetDataSource {
  RemoteCheatsheetDataSource({
    required NetworkService networkService,
  }) : _networkService = networkService;

  final NetworkService _networkService;

  @override
  TaskEither<CheatsheetDataSourceException, Cheatsheet> get(String byId) {
    final resource = CheatsheetResource(id: byId);
    final task = _networkService
        .request(resource)
        .mapLeft((error) => error.toCheatsheetDataSourceException())
        .flatMap(
          (res) => TaskEither.tryCatch(
            () async => Cheatsheet.fromJson(res.data),
            (error, st) => CheatsheetDataSourceException.parsing(
              error: error,
              stackTrace: st,
            ),
          ),
        );
    return task;
  }

  @override
  TaskEither<CheatsheetDataSourceException, List<CheatsheetMeta>> list() {
    final resource = CheatsheetListResource();
    final task = _networkService
        .request(resource)
        .mapLeft((error) => error.toCheatsheetDataSourceException())
        .flatMap(
          (res) => TaskEither.tryCatch(
            () async => (res.data as List<dynamic>)
                .map((item) => CheatsheetMeta.fromJson(item))
                .toList(),
            (error, st) => CheatsheetDataSourceException.parsing(
              error: error,
              stackTrace: st,
            ),
          ),
        );
    return task;
  }
}
