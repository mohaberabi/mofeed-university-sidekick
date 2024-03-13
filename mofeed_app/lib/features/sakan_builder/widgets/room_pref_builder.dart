import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/sakan_builder/cubit/skan_builder_ext.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/chip_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/utils/enums/room_enums.dart';
import '../../../core/widgets/choicer.dart';
import '../../sakan/widgets/data_collector.dart';
import '../cubit/sakan_builder_cubit.dart';
import '../cubit/sakan_builder_state.dart';

class RoomPrefBuilder extends StatelessWidget {
  const RoomPrefBuilder({super.key});

  static const _spacer = SizedBox(height: AppSpacing.lg);

  @override
  Widget build(BuildContext context) {
    final sakanCubit = context.read<SakanBuilderCubit>();
    final style = context.titleLarge.copyWith(fontWeight: FontWeight.w600);
    final local = context.l10n;
    return BlocBuilder<SakanBuilderCubit, SakanBuilderState>(
        builder: (context, state) {
      return DataCollector(
        title: local.roomPref,
        children: [
          ChipBuilder<RoomAmenity>(
              header: state.amenitiesTitle(local),
              headerStyle: style,
              avatar: (amenity) =>
                  amenity.logo != null ? AppIcon(amenity.logo!) : null,
              items: RoomAmenity.values,
              selected: (amenity) => state.amenties.contains(amenity),
              title: (amenity) => amenity.tr(context.lang),
              onTap: (amenity) => sakanCubit.pickAmenity(amenity)),
          _spacer,
          Text(state.bathRoomTitle(local), style: style),
          ...[true, false].map((humanbool) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: RadioChoicer<bool>(
                onChanged: (v) => sakanCubit.formChanged(privateBathRoom: v),
                contentPadding: const EdgeInsets.all(AppSpacing.sm),
                value: humanbool,
                groupValue: state.privateBathRoom,
                title: Text(humanbool ? local.yes : local.no),
                selected: humanbool == state.privateBathRoom,
              ),
            );
          }),
          _spacer,
          Text(local.liveWithSameUniQ, style: style),
          ...[true, false].map((humanbool) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: RadioChoicer<bool>(
                onChanged: (v) => sakanCubit.formChanged(anyUniversity: v),
                contentPadding: const EdgeInsets.all(AppSpacing.sm),
                value: humanbool,
                groupValue: state.anyUniversity,
                title: Text(humanbool ? local.yes : local.no),
                selected: humanbool == state.anyUniversity,
              ),
            );
          }),
          _spacer,
        ],
      );
    });
  }
}
