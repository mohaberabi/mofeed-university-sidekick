import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/sakan/widgets/data_collector.dart';
import 'package:mofeduserpp/features/sakan_builder/cubit/sakan_builder_state.dart';
import 'package:mofeduserpp/features/sakan_builder/widgets/sakan_images_builder.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/input_formatters.dart';

import '../cubit/sakan_builder_cubit.dart';

class FlatInfoBuilder extends StatelessWidget {
  const FlatInfoBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sakanCubit = context.read<SakanBuilderCubit>();
    final style = context.titleLarge.copyWith(fontWeight: FontWeight.w600);

    return BlocBuilder<SakanBuilderCubit, SakanBuilderState>(
        builder: (context, state) {
      return DataCollector(
        title: l10n.flatInfo,
        children: [
          if (state.mateWanted)
            const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: SakanImagesBuilder()),
          CustomTextField(
            initialValue: state.nearestServices.toString(),
            filled: false,
            onChanged: (v) =>
                sakanCubit.formChanged(nearestServices: double.parse(v)),
            label: l10n.howFarNearServiceHint,
            hint: l10n.howFarNearServiceHint,
            labelStyle: style,
            textInputType: TextInputType.number,
            inputFomratters: [
              InputFormaters.onlyNumbers,
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  initialValue: state.meteres.toString(),
                  filled: false,
                  textInputType: TextInputType.number,
                  inputFomratters: [
                    InputFormaters.onlyNumbers,
                  ],
                  label: l10n.metres,
                  hint: "85m",
                  onChanged: (v) => sakanCubit.formChanged(minStay: v),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: CustomTextField(
                  initialValue: state.floor.toString(),
                  filled: false,
                  textInputType: TextInputType.number,
                  inputFomratters: [
                    InputFormaters.onlyNumbers,
                  ],
                  label: l10n.floor,
                  hint: "2",
                  onChanged: (v) => sakanCubit.formChanged(maxStay: v),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          CustomTextField(
            initialValue: state.currentRoomMates.toString(),
            filled: false,
            textInputType: TextInputType.number,
            inputFomratters: [
              InputFormaters.onlyNumbers,
            ],
            label: l10n.howManyMatesQ,
            labelStyle: context.bodyLarge,
            hint: "3",
            onChanged: (v) =>
                sakanCubit.formChanged(currentRoomMates: int.parse(v)),
          ),
        ],
      );
    });
  }
}
