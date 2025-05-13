import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CachedNetworkSvgPicture extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final WidgetBuilder? placeholderBuilder;
  final bool allowDrawingOutsideViewBox;
  final String? semanticsLabel;
  final Clip clipBehavior;
  final ColorFilter? colorFilter;
  final bool cacheColorFilter;
  final SvgTheme? theme;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  final bool matchTextDirection;
  final bool excludeFromSemantics;
  final bool forceRefresh;

  const CachedNetworkSvgPicture({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholderBuilder,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
    this.colorFilter,
    this.theme,
    this.colorBlendMode = BlendMode.srcIn,
    this.forceRefresh = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: getImageData(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          File? file = snapshot.data;
          return SvgPicture.file(
            file!,
            width: width,
            alignment: alignment,
            allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
            colorFilter: colorFilter,
            clipBehavior: clipBehavior,
            excludeFromSemantics: excludeFromSemantics,
            fit: fit,
            height: height,
            key: key,
            matchTextDirection: matchTextDirection,
            placeholderBuilder: placeholderBuilder,
            semanticsLabel: semanticsLabel,
            theme: theme,
          );
        }
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );
  }

  Future<File> getImageData() async {
    final instance = CustomCacheManager.instance;
    final cachedInfo = await instance.getFileFromCache(url);

    if (forceRefresh || cachedInfo == null) {
      final fileInfo = await instance.downloadFile(url, force: true);
      return fileInfo.file;
    }
    return cachedInfo.file;
  }
}

class CustomCacheManager {
  static final CacheManager instance = CacheManager(
    Config(
      "cheatsheetCacheDataKey",
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 200,
    ),
  );

  CustomCacheManager._();
}
