import 'package:cheat_sheets/shared/widgets/cached_svg_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final void Function()? onTap;
  final Color iconColor;
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
    this.iconColor = Colors.white,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: (backgroundColor != null)
            ? isDarkMode
                ? backgroundColor!.withOpacity(0.5)
                : backgroundColor!.withOpacity(0.8)
            : isDarkMode
                ? HexColor('#2B4365').withOpacity(0.8)
                : HexColor('#DDDDDD'),
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
                      Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    leadingIcon,
                    height: leadingIconSize,
                    width: leadingIconSize,
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
