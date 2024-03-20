import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/shared/widgets/cached_svg_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final void Function()? onTap;
  final Color? backgroundColor;
  final double leadingIconSize;
  final EdgeInsetsGeometry? contentPadding;

  const CustomListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.backgroundColor,
    this.leadingIconSize = 30,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: (backgroundColor != null)
            ? backgroundColor!.withOpacity(0.8)
            : context.colors.grey100,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            dense: true,
            contentPadding: contentPadding ?? const EdgeInsets.all(15),
            leading: (leadingIcon.startsWith('http'))
                ? CachedNetworkSvgPicture(
                    url: leadingIcon,
                    height: leadingIconSize,
                    width: leadingIconSize,
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(
                      context.colors.brandBlack,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    leadingIcon,
                    height: leadingIconSize,
                    width: leadingIconSize,
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(
                      context.colors.brandBlack,
                      BlendMode.srcIn,
                    ),
                  ),
            title: Text(
              title,
              style: context.textTheme.heading3Bold,
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
