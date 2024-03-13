import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/core/widgets/settings_summary.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_states.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/cta.dart';
import 'package:mofeed_shared/ui/widgets/switcher.dart';
import 'package:mofeed_shared/utils/enums/langauge_enum.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../../theme_changer/cubit/theme_changer_cubit.dart';

class AppSettingsCta extends StatelessWidget {
  const AppSettingsCta({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SettingsSummary(
      title: l10n.settings,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      stackedTitle: false,
      children: [
        CallToAction.custom(
          title: l10n.language,
          leading: Icon(
            Icons.translate,
            color: context.bodyLarge.color,
          ),
          trailing: BlocBuilder<LocalizationCubit, LocalizationState>(
              builder: (context, state) {
            if (state is ChangeLocalState) {
              return Switcher<AppLangsEnum>(
                  items: AppLangsEnum.values,
                  current: state.locale.languageCode.toAppLang,
                  onSwitch: (lang) async {
                    if (state.locale.languageCode == lang.code) {
                      return;
                    }
                    context.read<LocalizationCubit>().changeLanguage(lang.code);
                  },
                  label: (lang) => lang.tr(context.lang));
            } else {
              return const SizedBox();
            }
          }),
        ),
        CallToAction.custom(
            title: l10n.appearence,
            leading: Icon(
              context.theme.isDark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: context.bodyLarge.color,
            ),
            trailing: BlocBuilder<ThemeChangerCubit, ThemeMode>(
              builder: (context, state) {
                return Switcher<ThemeMode>(
                    key: const Key("themeModeSwitcherKey"),
                    items: ThemeMode.values,
                    current: state,
                    onSwitch: (mode) =>
                        context.read<ThemeChangerCubit>().changeTheme(mode),
                    label: (mode) => mode.tr(context.lang));
              },
            )),
      ],
    );
  }
}
