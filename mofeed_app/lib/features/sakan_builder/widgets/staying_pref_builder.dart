import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/sakan_builder/cubit/skan_builder_ext.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/chip_builder.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/input_formatters.dart';

import 'package:sakan/utils/enums/common_enums.dart';

import '../../sakan/widgets/data_collector.dart';
import '../cubit/sakan_builder_cubit.dart';
import '../cubit/sakan_builder_state.dart';

class StayingPrefBuilder extends StatelessWidget {
  const StayingPrefBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.titleLarge.copyWith(fontWeight: FontWeight.w600);
    final l10n = context.l10n;
    final sakanCubit = context.read<SakanBuilderCubit>();
    return BlocBuilder<SakanBuilderCubit, SakanBuilderState>(
        builder: (context, state) {
      return DataCollector(
        title: l10n.stayPref,
        children: [
          if (state.mateWanted)
            SwitchListTile.adaptive(
              title: Text(l10n.privateRoom, style: style),
              value: state.isSingle,
              onChanged: (v) => sakanCubit.formChanged(isSingle: v),
            ),
          CustomTextField(
            filled: false,
            onChanged: (v) => sakanCubit.formChanged(price: v),
            label: state.priceTitle(l10n),
            initialValue: state.price,
            hint: "2000 EGP",
            inputFomratters: [InputFormaters.decimalNumber],
            textInputType: const TextInputType.numberWithOptions(signed: true),
            labelStyle: style,
          ),
          if (state.mateWanted)
            SwitchListTile.adaptive(
              subtitle: Text(
                l10n.billsHint,
                style: context.bodyLarge.copyWith(color: Colors.grey),
              ),
              title: Text(l10n.billsIncludedQ, style: style),
              value: state.isBillIncluded,
              onChanged: (v) => sakanCubit.formChanged(isSingle: v),
            ),
          const SizedBox(height: AppSpacing.lg),
          Text(state.paymentTitle(l10n), style: style),
          const SizedBox(height: AppSpacing.lg),
          ChipBuilder(
            items: BillingPeriod.values,
            selected: (payment) => state.billingPeriod == payment,
            title: (billing) => billing.tr(context.lang),
            onTap: (billing) => sakanCubit.formChanged(billingPeriod: billing),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(state.stayingTitle(l10n), style: style),
          Text(l10n.leaveEmptyIfNotYetKnow,
              style: context.bodyMedium.copyWith(color: Colors.grey)),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  filled: false,
                  inputFomratters: [InputFormaters.onlyNumbers],
                  textInputType: TextInputType.number,
                  label: l10n.maxPeriod,
                  hint: l10n.maxPeriod,
                  initialValue: state.maxStay,
                  onChanged: (v) => sakanCubit.formChanged(minStay: v),
                  suffix: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(state.billingPeriod.tr(context.lang)),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: CustomTextField(
                  filled: false,
                  initialValue: state.minStay,
                  inputFomratters: [InputFormaters.onlyNumbers],
                  textInputType: TextInputType.number,
                  label: l10n.minPeriod,
                  hint: l10n.minPeriod,
                  onChanged: (v) => sakanCubit.formChanged(maxStay: v),
                  suffix: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(state.billingPeriod.tr(context.lang)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(state.roomReadyTitle(l10n), style: style),
          const SizedBox(height: AppSpacing.sm),
          ListTile(
            trailing: TextButton(
              child: Text(l10n.choose),
              onPressed: () async {
                final picked = await context.showAdaptiveDatePicker();
                sakanCubit.formChanged(availableFrom: picked);
              },
            ),
            shape: context.theme.primaryOutlineBorder,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            leading: const AppIcon(AppIcons.clock),
            title: Text(state.availableFrom == null
                ? l10n.chooseDate
                : state.availableFrom!.mDy),
          )
        ],
      );
    });
  }
}
