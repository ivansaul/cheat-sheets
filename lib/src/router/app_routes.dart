enum AppRoutes {
  cheatsheets('/'),
  cheatsheet('/cheatsheet'),
  cheatsheetSection('/cheatsheet-detail'),
  cheatsheetsSearch('/cheatsheet-search'),

  settings('/settings');

  final String path;
  const AppRoutes(this.path);
}
