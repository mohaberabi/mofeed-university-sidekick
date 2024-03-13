import 'package:flutter/material.dart';
import 'package:mofeed_shared/model/university_model.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class OrderHandover extends StatelessWidget {
  final List<FacultyModel> faculties;
  final FacultyModel? current;
  final void Function(FacultyModel) onChanged;
  final void Function(String) onFloorChanged;

  final void Function(String) onRoomChanged;

  const OrderHandover({
    super.key,
    required this.faculties,
    required this.current,
    required this.onFloorChanged,
    required this.onRoomChanged,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        title: Text(l10n.chooseHandoverBuil,
            style: context.titleLarge.copyWith(color: Colors.grey)),
        children: faculties.map((faculty) {
          final selected = current != null && current == faculty;
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            selected: selected,
            selectedTileColor: context.theme.isDark
                ? AppColors.primDark
                : AppColors.primMaterial.shade50,
            selectedColor: AppColors.primColor,
            titleTextStyle: selected ? context.titleLarge : context.bodyLarge,
            onTap: () => onChanged(faculty),
            subtitle: selected
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: CustomTextField(
                                color: context.theme.isDark
                                    ? AppColors.lightDark
                                    : Colors.white,
                                label: l10n.floor,
                                isColumed: false,
                                isOutlined: false,
                                hint: "0,1",
                                onChanged: onFloorChanged)),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                            child: CustomTextField(
                                color: context.theme.isDark
                                    ? AppColors.lightDark
                                    : Colors.white,
                                label: l10n.room,
                                hint: "B 3.5",
                                isColumed: false,
                                isOutlined: false,
                                onChanged: onRoomChanged))
                      ],
                    ),
                  )
                : null,
            title: Text(faculty.name[context.lang]),
          );
        }).toList(),
      ),
    );
  }
}
