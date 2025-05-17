import 'package:cheat_sheets/src/extensions/context.dart';
import 'package:cheat_sheets/src/features/cheatsheets/domain/cheatsheet.dart';
import 'package:cheat_sheets/src/features/cheatsheets/presentation/providers/cheatsheet_search_controller.dart';
import 'package:cheat_sheets/src/router/app_routes.dart';
import 'package:cheat_sheets/src/shared/widgets/async_value_widget.dart';
import 'package:cheat_sheets/src/shared/widgets/cached_svg_picture.dart';
import 'package:cheat_sheets/src/shared/widgets/searchable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';

class CheatsheetsSearchScreen extends StatelessWidget {
  const CheatsheetsSearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const _SearchableView(),
        titleSpacing: 0,
        actions: [const Gap(20)],
      ),
      body: const _BobyView(),
    );
  }
}

class _SearchableView extends ConsumerWidget {
  const _SearchableView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(cheatsheetSearchControllerProvider.notifier);

    return SearchableWidget(
      hintText: "Search",
      autoFocus: true,
      onChanged: (value) {
        notifier.onQueryChanged(value);
      },
    );
  }
}

class _BobyView extends ConsumerWidget {
  const _BobyView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cheatsheetsAsync = ref.watch(cheatsheetSearchControllerProvider);
    return AsyncValueWidget(
      asyncValue: cheatsheetsAsync,
      data: (listMeta) {
        return ListView.builder(
          itemCount: listMeta.length,
          itemBuilder: (context, index) {
            final meta = listMeta[index];
            return _ItemRowWidget(meta: meta).animate().fadeIn();
          },
        );
      },
    );
  }
}

class _ItemRowWidget extends StatelessWidget {
  const _ItemRowWidget({
    required this.meta,
  });

  final CheatsheetMeta meta;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: meta.background != null
              ? HexColor(meta.background!)
              : Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkSvgPicture(
          url: meta.icon,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        meta.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: buildSubtitleView(context),
      onTap: () => context.push(
        AppRoutes.cheatsheet.path,
        extra: meta.id,
      ),
    );
  }

  Widget buildSubtitleView(BuildContext context) {
    final items = [...?meta.categories, ...?meta.tags]
        .map(
          (e) => Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: context.appColor.backgroundSecondary,
            ),
            child: Text(e, style: context.textTheme.labelMedium),
          ),
        )
        .toList();

    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: items,
    );
  }
}
