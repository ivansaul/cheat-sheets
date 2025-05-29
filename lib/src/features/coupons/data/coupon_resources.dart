import 'package:cheat_sheets/src/shared/env.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';

class CouponListResource implements NetworkResource {
  const CouponListResource({
    int page = 1,
    int limit = 10,
    String sortBy = "sale_start",
  })  : _page = page,
        _limit = limit,
        _sortBy = sortBy;

  final int _page;
  final int _limit;
  final String _sortBy;

  @override
  String get baseURL => Env.couponBaseUrl;

  @override
  String? get path => Env.couponListPath;

  @override
  RequestType get method => RequestType.get;

  @override
  Map<String, dynamic>? get queryParam => {
        "page": _page.toString(),
        "limit": _limit.toString(),
        "sortBy": _sortBy,
      };

  @override
  Map<String, String>? get headers => null;

  @override
  Map<String, dynamic>? get body => null;
}

class CouponResource implements NetworkResource {
  CouponResource({
    required String slug,
  }) : _slug = slug;

  final String _slug;

  @override
  String get baseURL => Env.couponBaseUrl;

  @override
  String? get path => "${Env.couponPath}/$_slug";

  @override
  RequestType get method => RequestType.get;

  @override
  Map<String, dynamic>? get queryParam => null;

  @override
  Map<String, dynamic>? get body => null;

  @override
  Map<String, String>? get headers => null;
}
