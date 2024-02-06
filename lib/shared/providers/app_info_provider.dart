// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_info_provider.g.dart';

@Riverpod(keepAlive: true)
class AppInfo extends _$AppInfo {
  late PackageInfo _packageInfo;

  @override
  Future<AppInfoState> build() async {
    _packageInfo = await PackageInfo.fromPlatform();
    return AppInfoState(
      appName: _packageInfo.appName,
      packageName: _packageInfo.packageName,
      version: _packageInfo.version,
      buildNumber: _packageInfo.buildNumber,
    );
  }
}

class AppInfoState {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppInfoState({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });
}
