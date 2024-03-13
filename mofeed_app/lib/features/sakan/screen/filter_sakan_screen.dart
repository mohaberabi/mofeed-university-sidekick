import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/core/widgets/sliver_scafolld.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_cubit.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_state.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/chip_builder.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import 'package:sakan/utils/enums/common_enums.dart';
import 'package:sakan/utils/enums/room_enums.dart';

class SakanFilterScreen extends StatelessWidget {
  const SakanFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sakanCubit = context.read<SakanCubit>();
    final local = context.l10n;
    return BlocListener<SakanCubit, SakanState>(
      listenWhen: (prev, curr) => prev.state != curr.state,
      listener: (context, state) {
        if (state.state == SakanStatus.populated) {
          context.pop();
        }
      },
      child: SliverScaffold(
        expandedHeight: 50,
        bootomNavBar: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              TextButton(
                  onPressed: () => sakanCubit.clearFilters(),
                  child: Text(local.clearAll)),
              Expanded(
                child: PrimaryButton(
                  onPress: () => sakanCubit.getSakans(),
                  label: local.applyFilter,
                ),
              ),
            ],
          ),
        ),
        leading: TextButton(
            onPressed: () => Navigator.pop(context), child: Text(local.cancel)),
        title: Text(local.filterSakan),
        body: BlocBuilder<SakanCubit, SakanState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: context.headlineMedium,
                      ),
                      Slider(
                        value: 0.9,
                        onChanged: (v) {},
                      ),
                    ],
                  ),
                  ChipBuilder<RoomAmenity>(
                      header: local.amenities,
                      avatar: (amenity) =>
                          amenity.logo != null ? AppIcon(amenity.logo!) : null,
                      items: RoomAmenity.values,
                      selected: (amenity) => state.amenities == null
                          ? false
                          : state.amenities!.contains(amenity),
                      title: (amenity) => amenity.tr(context.lang),
                      onTap: (amenity) => sakanCubit.addAmenity(amenity)),
                  ChipBuilder(
                    header: local.paymentPeriod,
                    items: BillingPeriod.values,
                    selected: (payment) => state.period == payment,
                    title: (billing) => billing.tr(context.lang),
                    onTap: (billing) => sakanCubit.formChanged(period: billing),
                  ),
                  Column(
                    children: [
                      SwitchListTile.adaptive(
                        title: Text(local.billsIncludedQ,
                            style: context.titleLarge),
                        value: state.billIncluded ?? false,
                        onChanged: (v) =>
                            sakanCubit.formChanged(billIncluded: v),
                      ),
                      SwitchListTile.adaptive(
                        title:
                            Text(local.singleRoom, style: context.titleLarge),
                        value: state.isSingle ?? false,
                        onChanged: (v) => sakanCubit.formChanged(isSingle: v),
                      ),
                      SwitchListTile.adaptive(
                        title: Text(local.privateBathroom,
                            style: context.titleLarge),
                        value: state.privateBathRoom ?? false,
                        onChanged: (v) =>
                            sakanCubit.formChanged(privateBathRoom: v),
                      ),
                    ],
                  )
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: context.theme.scaffoldBackgroundColor,
                                borderRadius: 8.circle,
                              ),
                              child: e),
                        ))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
