import 'dart:io';

import 'package:flutter/material.dart';
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
    Key? key,
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
  }) : super(key: key);

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
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<File> getImageData() async {
    if (forceRefresh) {
      final downloadedFile = await DefaultCacheManager().downloadFile(url, force: true);
      return downloadedFile.file;
    }
    final file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }
}

class CachedNetworkSvgImageManageUtils {
  static void removeFileCache(String url) {
    DefaultCacheManager().removeFile(url).then((value) {
      debugPrint('File removed');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  void clearCacheAll() {
    DefaultCacheManager().emptyCache();
  }
}
