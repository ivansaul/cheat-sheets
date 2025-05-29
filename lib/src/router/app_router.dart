import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: "/cheatsheet",
  navigatorKey: _rootNavigatorKey,
  routes: $appRoutes,
);
