import 'package:cheat_sheets/src/features/home/data/home_repository.dart';
import 'package:cheat_sheets/src/features/home/data/home_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository_provider.g.dart';

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl();
}
