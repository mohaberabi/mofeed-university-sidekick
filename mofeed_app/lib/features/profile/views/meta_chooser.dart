import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/enums/user_prefs.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class MetaChooser<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final String Function(T) label;

  const MetaChooser({
    super.key,
    required this.items,
    required this.title,
    required this.label,
  });

  static Future<Gender?> updateGender(BuildContext context) async {
    final data = await showModalBottomSheet<Gender>(
      context: context,
      builder: (context) => MetaChooser(
        items: const [Gender.male, Gender.female],
        title: context.l10n.gender,
        label: (gender) => gender.tr(context.lang),
      ),
    );
    return data;
  }

  static Future<Smoking?> updateSmoking(BuildContext context) async {
    final data = await showModalBottomSheet<Smoking>(
        context: context,
        builder: (context) {
          return MetaChooser<Smoking>(
              items: Smoking.values,
              title: context.l10n.smoking,
              label: (smoking) => smoking.tr(context.lang));
        });
    return data;
  }

  static Future<Pet?> updatePet(BuildContext context) async {
    final data = await showModalBottomSheet<Pet>(
        context: context,
        builder: (context) {
          return MetaChooser<Pet>(
              items: Pet.values.where((element) => element != Pet.na).toList(),
              title: context.l10n.petOpinion,
              label: (pet) => pet.tr(context.lang));
        });

    return data;
  }

  static Future<Religion?> updateReligion(BuildContext context) async {
    final data = await showModalBottomSheet<Religion>(
        context: context,
        builder: (context) {
          return MetaChooser<Religion>(
              items: Religion.values
                  .where((element) => element != Religion.na)
                  .toList(),
              title: context.l10n.religion,
              label: (relig) => relig.tr(context.lang));
        });

    return data;
  }

  @override
  State<MetaChooser<T>> createState() => _MetaChooserState<T>();
}

class _MetaChooserState<T> extends State<MetaChooser<T>> {
  ValueNotifier<T?> choosed = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(widget.title, style: context.headLineLarge),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final t = widget.items[index];
                return Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: ValueListenableBuilder(
                        valueListenable: choosed,
                        builder: (context, value, child) {
                          return ListTile(
                            onTap: () {
                              choosed.value = t;
                            },
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            leadingAndTrailingTextStyle: context.titleLarge,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: value == t
                                        ? AppColors.primColor
                                        : Colors.grey,
                                    width: value == t ? 2 : 1),
                                borderRadius: 8.circle),
                            leading: Text(widget.label(t)),
                          );
                        }));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xlg),
            child: PrimaryButton(
              onPress: () => Navigator.pop(context, choosed.value),
              label: context.l10n.save,
            ),
          )
        ],
      ),
    );
  }
}
