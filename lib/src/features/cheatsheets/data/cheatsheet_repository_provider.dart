import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_repository.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_repository_impl.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/remote_cheatsheet_data_source.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheatsheet_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CheatsheetRepository cheatsheetRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider);
  return CheatsheetRepositoryImpl(
    dataSource: RemoteCheatsheetDataSource(
      networkService: networkService,
    ),
  );
}
