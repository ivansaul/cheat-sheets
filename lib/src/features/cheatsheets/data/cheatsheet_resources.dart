import 'package:cheat_sheets/src/shared/env.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';

final class CheatsheetListResource implements NetworkResource {
  @override
  String get baseURL => Env.apiCheatsheetBaseUrl;

  @override
  String? get path => Env.apiCheatsheetListEndpoint;

  @override
  RequestType get method => RequestType.get;

  @override
  Map<String, dynamic>? get body => null;

  @override
  Map<String, String>? get headers => null;

  @override
  Map<String, dynamic>? get queryParam => null;
}

final class CheatsheetResource implements NetworkResource {
  CheatsheetResource({
    required String id,
  }) : _id = id;

  final String _id;

  @override
  String get baseURL => Env.apiCheatsheetBaseUrl;

  @override
  String? get path => Env.apiCheatsheetDetailEndpoint.replaceFirst(":id", _id);

  @override
  RequestType get method => RequestType.get;

  @override
  Map<String, dynamic>? get body => null;

  @override
  Map<String, String>? get headers => null;

  @override
  Map<String, dynamic>? get queryParam => null;
}
