import 'package:json_annotation/json_annotation.dart';

part 'cheatsheet.g.dart';

@JsonSerializable()
class Cheatsheet {
  final String id;
  final String title;
  final List<String>? tags;
  final List<String>? categories;
  final String? background;
  final String icon;
  final String? intro;
  final List<SectionSheet> sections;

  const Cheatsheet({
    required this.id,
    required this.title,
    required this.tags,
    required this.categories,
    required this.background,
    required this.icon,
    required this.intro,
    required this.sections,
  });

  factory Cheatsheet.fromJson(Map<String, dynamic> json) =>
      _$CheatsheetFromJson(json);

  Map<String, dynamic> toJson() => _$CheatsheetToJson(this);
}

@JsonSerializable()
class SectionSheet {
  final String title;
  final String content;
  SectionSheet({
    required this.title,
    required this.content,
  });

  factory SectionSheet.fromJson(Map<String, dynamic> json) =>
      _$SectionSheetFromJson(json);

  Map<String, dynamic> toJson() => _$SectionSheetToJson(this);
}

@JsonSerializable()
class CheatsheetMeta {
  final String id;
  final String title;
  final List<String>? tags;
  final List<String>? categories;
  final String? background;
  final String icon;
  final String? intro;

  const CheatsheetMeta({
    required this.id,
    required this.title,
    required this.tags,
    required this.categories,
    required this.background,
    required this.icon,
    required this.intro,
  });

  factory CheatsheetMeta.fromJson(Map<String, dynamic> json) =>
      _$CheatsheetMetaFromJson(json);

  Map<String, dynamic> toJson() => _$CheatsheetMetaToJson(this);
}
