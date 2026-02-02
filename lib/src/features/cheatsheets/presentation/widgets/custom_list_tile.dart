import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/extensions/text_style.dart';
import 'package:cheat_sheets/src/shared/widgets/cached_svg_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_list_tile.freezed.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.backgroundColor,
    this.leadingIconSize = 20,
    this.contentPadding,
  });

  final String title;
  final IconSource leadingIcon;
  final void Function()? onTap;
  final Color? backgroundColor;
  final double leadingIconSize;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: context.appColor.backgroundSecondary,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            leading: Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor,
              ),
              child: _buildLeadingIcon(context),
            ),
            title: Text(
              title,
              style: context.textTheme.titleMedium?.bold(),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return switch (leadingIcon) {
      IconSourceIcon(:final data) => Icon(
          data,
          size: leadingIconSize,
        ),
      IconSourceNetwork(:final url) => CachedNetworkSvgPicture(
          url: url,
          fit: BoxFit.fitHeight,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      IconSourceAsset(:final path) => SvgPicture.asset(
          path,
          fit: BoxFit.fitHeight,
          colorFilter: ColorFilter.mode(
            context.colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
    };
  }
}

@freezed
sealed class IconSource with _$IconSource {
  const IconSource._();
  const factory IconSource.icon(IconData data) = IconSourceIcon;
  const factory IconSource.network(String url) = IconSourceNetwork;
  const factory IconSource.asset(String path) = IconSourceAsset;
}
