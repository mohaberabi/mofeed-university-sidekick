import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/option/cubit/option_cubit.dart';
import 'package:mofeed_owner/features/option/cubit/option_state.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/input_formatters.dart';
import 'package:mofeed_shared/utils/style/app_colors.dart';
import 'package:mofeed_shared/utils/style/shapes.dart';
import 'package:mofeed_shared/widgets/custom_texfield.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/primary_button.dart';

class AddFoodOptionScreen extends StatelessWidget {
  const AddFoodOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add option"),
      ),
      body: BlocConsumer<OptionCubit, OptionState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    initialValue: state.option.name['ar'],
                    label: "Name arabic ",
                    onChanged: (v) =>
                        context.read<OptionCubit>().formChanged(ar: v),
                  )),
                  8.width,
                  Expanded(
                      child: CustomTextField(
                    label: "Name english ",
                    initialValue: state.option.name['en'],
                    onChanged: (v) =>
                        context.read<OptionCubit>().formChanged(en: v),
                  )),
                ],
              ),
              ExpansionTile(
                leading: IconButton(
                    onPressed: () => context.read<OptionCubit>().addChild(),
                    icon: const Icon(Icons.add)),
                title: Text("Options"),
                children: List.generate(state.option.children.length,
                    (index) => _ChildOption(index: index)),
              ),
              20.height,
              state.status.builder({
                OptionStatus.loading: () => const Loader(),
              },
                  placeHolder: PrimaryButton(
                    onPress: state.readyToAdd
                        ? () => context.read<OptionCubit>().addOption()
                        : null,
                    label: "Save Option",
                  ))
            ],
          );
        },
        listener: (context, state) {
          state.status.when(
            {
              OptionStatus.add: () =>
                  showSnackBar(context, message: "Option Added", doBefore: () {
                    context.read<OptionCubit>().clearForm();
                  }, whenClosed: () {
                    Navigator.pop(context);
                  }),
            },
          );
        },
        listenWhen: (prev, curr) => prev.status != curr.status,
      ),
    );
  }
}

class _ChildOption extends StatelessWidget {
  final int index;

  const _ChildOption({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final state =
        context.select<OptionCubit, OptionState>((value) => value.state);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: 4.circle,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primColor,
                borderRadius: 4.circle,
              ),
              child: Text(
                '${index + 1}',
                style: context.button,
              ),
            ),
            8.width,
            Expanded(
              child: Column(
                children: [
                  CustomTextField(
                    isColumed: false,
                    isOutlined: false,
                    label: "Name arabic ",
                    initialValue: state.option.children[index].name['ar'],
                    onChanged: (v) =>
                        context.read<OptionCubit>().childChanged(index, ar: v),
                  ),
                  16.height,
                  CustomTextField(
                    label: "Name english ",
                    isColumed: false,
                    isOutlined: false,
                    initialValue: state.option.children[index].name['en'],
                    onChanged: (v) =>
                        context.read<OptionCubit>().childChanged(index, ar: v),
                  ),
                  16.height,
                  CustomTextField(
                    label: "Price",
                    initialValue: state.option.children[index].price.toString(),
                    isColumed: false,
                    isOutlined: false,
                    textInputType:
                        const TextInputType.numberWithOptions(signed: true),
                    inputFomratters: [
                      InputFormaters.decimalNumber,
                    ],
                    onChanged: (v) => context
                        .read<OptionCubit>()
                        .childChanged(index, price: v),
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: () => context.read<OptionCubit>().removeChild(index),
                icon: const Icon(Icons.delete_outline_rounded))
          ],
        ),
      ),
    );
  }
}
