import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AsyncImage extends StatelessWidget {
  const AsyncImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.borderRadius = BorderRadius.zero,
  });

  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        url,
        fit: fit,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ?? _defaultPlaceholder;
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _defaultPlaceholder;
        },
      ),
    );
  }

  Widget get _defaultPlaceholder {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          color: Colors.blueGrey.withValues(alpha: 0.3),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            color: Colors.white.withAlpha(1),
            child: const CupertinoActivityIndicator(),
          ),
        ),
      ],
    );
  }
}
