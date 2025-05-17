import 'package:cheat_sheets/src/features/cheatsheets/data/cheatsheet_repository.dart';
import 'package:cheat_sheets/src/features/cheatsheets/data/local_cheatsheet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheatsheet_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CheatsheetRepository cheatsheetRepository(Ref ref) {
  return LocalCheatsheetRepository();
}
