import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/file_iamge.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import '../cubit/sakan_builder_cubit.dart';
import '../cubit/sakan_builder_state.dart';

class SakanImagesBuilder extends StatelessWidget {
  const SakanImagesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SakanBuilderCubit, SakanBuilderState>(
        builder: (context, state) {
      if (state.roomImages.isEmpty) {
        return Container(
            alignment: AlignmentDirectional.center,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: 8.circle,
                border: Border.all(color: context.theme.dividerColor)),
            child: _adder(context));
      } else {
        return Column(
          children: [
            if (state.roomImages.length < 10)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_adder(context)],
              ),
            SizedBox(
              height: 236,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.sm),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final fileImage = state.roomImages[index];
                  return CustomFileImage(
                    h: 236,
                    w: 200,
                    file: fileImage.toFile,
                    onDelete: () =>
                        context.read<SakanBuilderCubit>().removeImage(index),
                  );
                },
                itemCount: state.roomImages.length,
              ),
            ),
          ],
        );
      }
    });
  }

  Widget _adder(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<SakanBuilderCubit>().pikcupImages(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add),
            Text(
              context.l10n.addImages,
              style: context.button.copyWith(color: AppColors.primColor),
            )
          ],
        ),
      ),
    );
  }
}
