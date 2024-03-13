import 'package:flutter/material.dart';
import 'package:food_court/model/food_option.dart';
import 'package:food_court/model/option_group.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class GroupOptionsBuilder extends StatelessWidget {
  final OptionGroup parent;
  final void Function(FoodOption) onVariantChoseed;
  final bool Function(FoodOption) selected;

  const GroupOptionsBuilder({
    Key? key,
    required this.parent,
    required this.onVariantChoseed,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              title: Text('${l10n.choose} ${parent.name[context.lang]}',
                  style: context.titleLarge),
              trailing: Text('${l10n.choose} ${parent.min}',
                  style: context.bodyLarge.copyWith(color: Colors.grey))),
          ...List.generate(
            parent.children.length,
            (index) {
              final option = parent.children[index];
              return Column(
                children: [
                  ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 50, maxHeight: 75),
                      child: _ChoiceHandeler(
                          option: option,
                          selected: selected(option),
                          onChoose: () => onVariantChoseed(option),
                          allowsMultiple: parent.multiChoice)),
                  if (option != parent.children.last) const Divider(height: 0),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ChoiceHandeler extends StatelessWidget {
  final FoodOption option;
  final VoidCallback onChoose;
  final bool selected;
  final bool allowsMultiple;

  const _ChoiceHandeler({
    Key? key,
    required this.option,
    required this.allowsMultiple,
    required this.selected,
    required this.onChoose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onChoose,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      leading: Text(option.name[context.lang], style: context.bodyLarge),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(option.price.toPrice(context.lang),
              style: context.bodyMedium.copyWith(color: Colors.grey)),
          const SizedBox(width: AppSpacing.sm),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selected ? Colors.green : Colors.transparent,
                  shape: allowsMultiple ? BoxShape.rectangle : BoxShape.circle,
                  border: selected
                      ? null
                      : Border.all(color: Colors.grey, width: 1.8)),
              width: 20,
              height: 20,
              child: selected
                  ? const Icon(Icons.done, color: Colors.white, size: 18)
                  : null),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
    );
  }
}
