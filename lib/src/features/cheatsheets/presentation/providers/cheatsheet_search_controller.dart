import 'dart:async';

import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/providers/cheatsheet_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cheatsheet_search_controller.g.dart';

@riverpod
class CheatsheetSearchController extends _$CheatsheetSearchController {
  Timer? _debounce;

  @override
  Future<List<CheatsheetMeta>> build() async {
    ref.onDispose(() => _debounce?.cancel());
    return _fetchCheatsheets();
  }

  Future<void> onQueryChanged(String query) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() => _filterCheatsheets(query));
    });
  }

  Future<List<CheatsheetMeta>> _fetchCheatsheets() async {
    return ref.watch(cheatsheetsControllerProvider.future);
  }

  Future<List<CheatsheetMeta>> _filterCheatsheets(String query) async {
    final cheatsheets = await _fetchCheatsheets();
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return cheatsheets;

    return cheatsheets.where((item) {
      final title = item.title.toLowerCase();
      final intro = item.intro?.toLowerCase() ?? '';
      final tags = item.tags?.map(
            (tag) => tag.toLowerCase(),
          ) ??
          const [];
      final categories = item.categories?.map(
            (cat) => cat.toLowerCase(),
          ) ??
          const [];

      final matchesTitle = title.contains(normalizedQuery);
      final matchesIntro = intro.contains(normalizedQuery);
      final matchesTags = tags.any(
        (tag) => tag.contains(normalizedQuery),
      );
      final matchesCategories = categories.any(
        (cat) => cat.contains(normalizedQuery),
      );

      return matchesTitle || matchesIntro || matchesTags || matchesCategories;
    }).toList();
  }
}
