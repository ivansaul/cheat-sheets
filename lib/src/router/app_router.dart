import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheet_screen.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheet_section_screen.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheets_screen.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheets_search_screen.dart';
import 'package:cheat_sheets/src/features/settings/settings_screen.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.cheatsheets.path,
  routes: [
    GoRoute(
      path: AppRoutes.cheatsheets.path,
      builder: (context, state) => const CheatsheetsScreen(),
    ),
    GoRoute(
      path: AppRoutes.cheatsheet.path,
      builder: (context, state) {
        final sheetId = state.extra as String;
        return CheatsheetScreen(
          sheetId: sheetId,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.cheatsheetSection.path,
      builder: (context, state) {
        final section = state.extra as SectionSheet;
        return CheatsheetSectionScreen(
          section: section,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.settings.path,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.cheatsheetsSearch.path,
      builder: (context, state) => const CheatsheetsSearchScreen(),
    ),
  ],
);
