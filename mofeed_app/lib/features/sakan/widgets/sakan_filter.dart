import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:sakan/utils/enums/common_enums.dart';

import '../screen/filter_sakan_screen.dart';

class SakanFilter extends StatelessWidget {
  final void Function(SakanType) onChanged;
  final bool hasFilters;
  final bool showFilters;

  final SakanType? current;

  const SakanFilter({
    super.key,
    required this.current,
    required this.onChanged,
    this.hasFilters = false,
    this.showFilters = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...SakanType.values.map((type) {
        final selected = type == current;
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: GestureDetector(
            onTap: () => onChanged(type),
            child: AppIcon(
              type.icon,
              size: 30,
              color: selected ? AppColors.primColor : Colors.grey,
            ),
          ),
        );
      }).toList(),
      const Spacer(),
      if (showFilters)
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return SizedBox(
                    height: context.height * 0.9,
                    child: const SakanFilterScreen(),
                  );
                },
              );
            },
            icon: Icon(Icons.filter_list,
                color: hasFilters ? AppColors.primColor : Colors.grey,
                size: 30))
    ]);
  }
}
