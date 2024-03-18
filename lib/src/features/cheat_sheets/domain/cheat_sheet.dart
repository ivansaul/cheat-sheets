import 'package:json_annotation/json_annotation.dart';

part 'cheat_sheet.g.dart';

@JsonSerializable()
class CheatSheet {
  final String title;
  final String background;
  final List<String> tags;
  final List<String> categories;
  final String icon;
  final String intro;
  final List<CheatSheetSection> sections;

  CheatSheet({
    required this.title,
    this.background = '#2B4365',
    this.tags = const [],
    this.categories = const [],
    required this.icon,
    required this.intro,
    required this.sections,
  });

  factory CheatSheet.fromJson(Map<String, dynamic> json) =>
      _$CheatSheetFromJson(json);

  Map<String, dynamic> toJson() => _$CheatSheetToJson(this);
}

@JsonSerializable()
class CheatSheetSection {
  final String title;
  final String content;
  CheatSheetSection({
    required this.title,
    required this.content,
  });

  factory CheatSheetSection.fromJson(Map<String, dynamic> json) =>
      _$CheatSheetSectionFromJson(json);

  Map<String, dynamic> toJson() => _$CheatSheetSectionToJson(this);
}
