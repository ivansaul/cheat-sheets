import 'package:json_annotation/json_annotation.dart';

/// JSON converter for nullable `double` values.
///
/// Safely converts dynamic JSON values into `double?`, supporting:
/// `null`, `num`, and numeric `String` values.
/// Returns `null` if the value cannot be converted.
class DoubleConverter implements JsonConverter<double?, dynamic> {
  const DoubleConverter();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json);
    return null;
  }

  @override
  toJson(double? object) => object;
}
