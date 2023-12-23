import 'package:cheat_sheets/config/router/app_routes.dart';
import 'package:cheat_sheets/features/home/domain/cheat_sheet_model.dart';
import 'package:cheat_sheets/features/home/presentation/screens/detail_screen.dart';
import 'package:cheat_sheets/features/home/presentation/screens/home_screen.dart';
import 'package:cheat_sheets/features/home/presentation/screens/sections_screen.dart';
import 'package:cheat_sheets/features/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.sections.path,
      builder: (context, state) {
        final cheatSheet = state.extra as CheatSheetModel;
        return SectionsScreen(
          cheatSheet: cheatSheet,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.details.path,
      builder: (context, state) {
        final section = state.extra as Section;
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
