import 'package:cheat_sheets/src/features/cheat_sheets/domain/cheat_sheet.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/presentation/screens/cheat_sheets_screen.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/presentation/screens/cheat_sheet_detail_screen.dart';
import 'package:cheat_sheets/src/features/cheat_sheets/presentation/screens/cheat_sheet_sections_screen.dart';
import 'package:cheat_sheets/src/features/settings/settings_screen.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const CheatSheetsScreen(),
    ),
    GoRoute(
      path: AppRoutes.sections.path,
      builder: (context, state) {
        final cheatSheet = state.extra as CheatSheet;
        return SectionsScreen(
          cheatSheet: cheatSheet,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.details.path,
      builder: (context, state) {
        final section = state.extra as CheatSheetSection;
        return DetailsScreen(
          section: section,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.settings.path,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
