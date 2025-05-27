import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheet_detail_screen.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheet_list_screen.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheet_screen.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/screens/cheatsheet_search_screen.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/screens/coupon_list_screen.dart';
import 'package:cheat_sheets/src/features/coupons/presentation/screens/coupon_screen.dart';
import 'package:cheat_sheets/src/features/settings/settings_screen.dart';
import 'package:cheat_sheets/src/shared/widgets/scaffold_with_nested_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

final _shellNavigatorKeyCheatsheet = GlobalKey<NavigatorState>();
final _shellNavigatorKeyCoupons = GlobalKey<NavigatorState>();
final _shellNavigatorKeySettings = GlobalKey<NavigatorState>();

@TypedStatefulShellRoute<RootShellRoute>(
  branches: [
    TypedStatefulShellBranch<ShellBranchCheatsheets>(
      routes: [
        TypedGoRoute<CheatsheetListRoute>(
          path: "/cheatsheet",
          routes: [
            TypedGoRoute<CheatsheetSearchRoute>(
              path: "search",
            ),
            TypedGoRoute<CheatsheetDetailRoute>(
              path: "detail",
            ),
            TypedGoRoute<CheatsheetRoute>(
              path: ":sheetId",
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ShellBranchCoupons>(
      routes: [
        TypedGoRoute<CouponListRoute>(
          path: "/coupon",
          routes: [
            TypedGoRoute<CouponRoute>(
              path: ":slug",
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ShellBranchSettings>(
      routes: [
        TypedGoRoute<SettingsRoute>(
          path: "/settings",
        ),
      ],
    ),
  ],
)
class RootShellRoute extends StatefulShellRouteData {
  const RootShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNestedNavigation(
      navigationShell: navigationShell,
    );
  }
}

// ==============================
// === 📚 CHEAT SHEETS ROUTES ===
// ==============================

class ShellBranchCheatsheets extends StatefulShellBranchData {
  const ShellBranchCheatsheets();

  static final GlobalKey<NavigatorState> $navigatorKey =
      _shellNavigatorKeyCheatsheet;
}

class CheatsheetListRoute extends GoRouteData {
  const CheatsheetListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CheatsheetListScreen();
  }
}

class CheatsheetRoute extends GoRouteData {
  const CheatsheetRoute({required this.sheetId});

  final String sheetId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CheatsheetScreen(sheetId: sheetId);
  }
}

class CheatsheetDetailRoute extends GoRouteData {
  const CheatsheetDetailRoute(this.$extra);

  final SectionSheet $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CheatsheetDetailScreen(section: $extra);
  }
}

class CheatsheetSearchRoute extends GoRouteData {
  const CheatsheetSearchRoute();

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: const CheatsheetSearchScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

// =========================
// === 💰 COUPONS ROUTES ===
// =========================

class ShellBranchCoupons extends StatefulShellBranchData {
  const ShellBranchCoupons();

  static final GlobalKey<NavigatorState> $navigatorKey =
      _shellNavigatorKeyCoupons;
}

class CouponListRoute extends GoRouteData {
  const CouponListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CouponListScreen();
  }
}

class CouponRoute extends GoRouteData {
  const CouponRoute({required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CouponScreen(slug: slug);
  }
}

// ==========================
// === ⚙️ SETTINGS ROUTES ===
// ==========================

class ShellBranchSettings extends StatefulShellBranchData {
  const ShellBranchSettings();

  static final GlobalKey<NavigatorState> $navigatorKey =
      _shellNavigatorKeySettings;
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}
