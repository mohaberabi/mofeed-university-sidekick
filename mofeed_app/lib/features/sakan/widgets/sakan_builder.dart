import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_state.dart';
import 'package:mofeduserpp/features/sakan/widgets/sakan_card.dart';
import 'package:mofeduserpp/features/sakan/widgets/sakan_filter.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/routes/sakan_routes.dart';
import 'package:sakan/utils/enums/common_enums.dart';
import '../../../core/services/service_lcoator.dart';
import '../cubit/sakan_cubit/sakan_cubit.dart';

class SakanBuilder extends StatelessWidget {
  final bool getMine;

  const SakanBuilder({super.key, this.getMine = false});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => sl<SakanCubit>()..getSakans(getMine: getMine),
      child: BlocBuilder<SakanCubit, SakanState>(
        builder: (context, state) {
          final populated = AppViewBuilder.list(
            seprator: (context, index) => const SizedBox(height: AppSpacing.lg),
            padding: const EdgeInsets.all(AppSpacing.lg),
            onRefresh: () async => _getSakans(
              context,
              type: state.sakanType,
            ),
            onMax: () async => _getSakans(
              context,
              loadBefore: false,
              clearBefore: false,
              type: state.sakanType,
            ),
            builder: (context, index) {
              final sakan = state.sakans.values.toList()[index];
              return GestureDetector(
                onTap: () => context.navigateTo(
                    routeName: SakanRoutes.viewSakanScreen, args: sakan),
                child: SakanCard(sakan: sakan),
              );
            },
            count: state.sakans.length,
            placeHolder: AppPlaceHolder.empty(
              title: l10n.noListingsAdded,
              subtitle: l10n.comBackLater,
            ),
          );

          final selectedType = state.sakanType;
          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SakanFilter(
                    showFilters: !getMine,
                    current: selectedType,
                    onChanged: (type) => context
                        .read<SakanCubit>()
                        .typeChanged(type, getMine: getMine),
                    hasFilters: state.hasFilters,
                  ),
                ],
              ),
              Expanded(
                child: state.state.builder(
                  {
                    SakanStatus.loading: () => const Loader(),
                    SakanStatus.error: () => AppPlaceHolder.error(
                          onTap: () => _getSakans(
                            context,
                            loadBefore: true,
                            clearBefore: true,
                            type: state.sakanType,
                          ),
                          title: l10n.localizeError(state.error),
                        ),
                    SakanStatus.populated: () => populated,
                  },
                  placeHolder: populated,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _getSakans(
    BuildContext context, {
    bool loadBefore = true,
    bool clearBefore = true,
    SakanType type = SakanType.mateWanted,
  }) =>
      context.read<SakanCubit>().getSakans(
          loadBefore: loadBefore,
          clearBefore: clearBefore,
          getMine: getMine,
          type: type);
  static const Widget add = _Add();
}

class _Add extends StatelessWidget {
  const _Add({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.navigateTo(routeName: SakanRoutes.addSakanScreen);
        },
        icon: const AppIcon(AppIcons.edit));
  }
}
