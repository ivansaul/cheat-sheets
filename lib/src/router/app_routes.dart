enum AppRoutes {
  home('/'),
  sections('/sections'),
  details('/details'),
  settings('/settings');

  final String path;
  const AppRoutes(this.path);
}
