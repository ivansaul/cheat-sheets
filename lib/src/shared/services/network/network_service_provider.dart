import 'package:cheat_sheets/src/shared/services/network/dio_network_service.dart';
import 'package:cheat_sheets/src/shared/services/network/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_service_provider.g.dart';

@Riverpod(keepAlive: true)
NetworkService networkService(Ref ref) {
  return DioNetworkService();
}
