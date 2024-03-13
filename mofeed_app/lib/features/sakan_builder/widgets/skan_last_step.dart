import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/sakan_builder/cubit/sakan_builder_state.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/app_address.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/input_formatters.dart';

import '../../sakan/widgets/data_collector.dart';
import '../cubit/sakan_builder_cubit.dart';

class SakanLastStep extends StatelessWidget {
  const SakanLastStep({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.titleLarge.copyWith(fontWeight: FontWeight.w600);
    final local = context.l10n;
    final sakanCubit = context.read<SakanBuilderCubit>();
    return BlocBuilder<SakanBuilderCubit, SakanBuilderState>(
        builder: (context, state) {
      return DataCollector(
        title: local.justOneStep,
        children: [
          CustomTextField(
              errorText: state.titleError.isEmpty ? null : state.titleError,
              initialValue: state.title,
              filled: false,
              onChanged: (v) => sakanCubit.formChanged(title: v),
              label: local.giveTitle,
              hint: local.sakanRequstTtlHint,
              isColumed: true,
              maxLength: 50,
              labelStyle: style),
          const SizedBox(height: AppSpacing.sm),
          Text(local.gieveDesc, style: style),
          const SizedBox(height: AppSpacing.sm),
          CustomTextField(
            errorText:
                state.describitonError.isEmpty ? null : state.describitonError,
            filled: false,
            initialValue: state.description,
            onChanged: (v) => sakanCubit.formChanged(description: v),
            label: "",
            hint: local.shareSomeInfo,
            isColumed: false,
            isOutlined: true,
            maxLength: 300,
            labelStyle: style,
            hintStyle: context.bodyLarge.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: AppSpacing.sm),
          SwitchListTile.adaptive(
              title: Text(local.showPhoneNo),
              value: state.showPhoneNumber,
              onChanged: (v) => sakanCubit.formChanged(showPhoneNumber: v)),
          if (state.showPhoneNumber)
            CustomTextField(
              filled: false,
              initialValue: state.phone,
              inputFomratters: [
                InputFormaters.phoneLength,
                InputFormaters.onlyNumbers,
              ],
              onChanged: (v) => sakanCubit.formChanged(phone: v),
              label: local.phoneNo,
              hint: "",
            ),
          const SizedBox(height: AppSpacing.xlg),
          if (state.mateWanted)
            ListTile(
              onTap: () async {
                final address = await context.navigateTo(
                    routeName: AppRoutes.searchPlacesScreen);
                if (address != null) {
                  sakanCubit.addressChanged(address as AppAddress);
                }
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              shape: context.theme.primaryOutlineBorder,
              horizontalTitleGap: 0,
              leading: const Icon(Icons.pin_drop_outlined),
              title: Text(state.address?.subName ?? local.address),
              subtitle: Text(state.address != null
                  ? state.address!.name
                  : local.chooseAddress),
            ),
        ],
      );
    });
  }
}
