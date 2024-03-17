import 'package:json_annotation/json_annotation.dart';

part 'cheat_sheet_model.g.dart';

@JsonSerializable()
class CheatSheetModel {
  final String title;
  final String background;
  final List<String> tags;
  final List<String> categories;
  final String icon;
  final String intro;
  final List<Section> sections;

  CheatSheetModel({
    required this.title,
    this.background = '#2B4365',
    this.tags = const [],
    this.categories = const [],
    required this.icon,
    required this.intro,
    required this.sections,
  });

  factory CheatSheetModel.fromJson(Map<String, dynamic> json) =>
      _$CheatSheetModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheatSheetModelToJson(this);
}

@JsonSerializable()
class Section {
  final String title;
  final String content;
  Section({
    required this.title,
    required this.content,
  });

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
