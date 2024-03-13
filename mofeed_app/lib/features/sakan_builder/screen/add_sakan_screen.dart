import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_cubit.dart';
import 'package:mofeduserpp/features/sakan_builder/widgets/room_info_builder.dart';
import 'package:mofeduserpp/features/sakan_builder/widgets/room_pref_builder.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/chip_builder.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/primary_button.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/common_enums.dart';
import '../cubit/sakan_builder_cubit.dart';
import '../cubit/sakan_builder_state.dart';
import '../widgets/skan_last_step.dart';
import '../widgets/staying_pref_builder.dart';

class AddSakanScreen extends StatefulWidget {
  const AddSakanScreen({super.key});

  @override
  State<AddSakanScreen> createState() => _AddSakanScreenState();
}

class _AddSakanScreenState extends State<AddSakanScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context
        .select<SakanBuilderCubit, SakanBuilderState>((value) => value.state);
    final l10n = context.l10n;
    return BlocListener<SakanBuilderCubit, SakanBuilderState>(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          bottomNavigationBar: Container(
              color: context.theme.scaffoldBackgroundColor,
              height: 100,
              child: Column(
                children: [
                  LinearProgressIndicator(
                      backgroundColor: Colors.grey, value: state.progress),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.pageIndex >= 1)
                        TextButton(
                            onPressed: () => _animatePages(state.pageIndex - 1),
                            child: Text(l10n.back)),
                      state.state.isLoading
                          ? const Loader()
                          : Padding(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              child: PrimaryButton(
                                onPress: state.formValid
                                    ? () {
                                        if (state.isLastStep) {
                                          _addSakan(context);
                                        } else {
                                          _animatePages(state.pageIndex + 1);
                                        }
                                      }
                                    : null,
                                label: l10n.next,
                                maximumSize: const Size(200, 50),
                                minimumSize: const Size(100, 45),
                              ),
                            ),
                    ],
                  )
                ],
              )),
          appBar: AppBar(
            leadingWidth: context.width * 0.4,
            leading: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: GestureDetector(
                onTap: () => _saveAndExit(context),
                child: Text(l10n.saveExit,
                    style: context.button.copyWith(color: AppColors.primColor)),
              ),
            ),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) => _onPageChanged(context, index: index),
            children: [
              ChipBuilder(
                  header: l10n.howToUseMofeed,
                  spacing: context.width,
                  chipBuilderShape: ChipBuilderShape.tile,
                  items: SakanType.values,
                  selected: (type) => state.sakanType == type,
                  title: (type) => type.subtitle[context.lang],
                  onTap: (type) => context
                      .read<SakanBuilderCubit>()
                      .formChanged(sakanType: type)),
              const RoomPrefBuilder(),
              const StayingPrefBuilder(),
              if (state.mateWanted) const FlatInfoBuilder(),
              const SakanLastStep(),
            ],
          ),
        ),
      ),
      listener: (context, state) {
        if (state.state.isError) {
          context.showSnackBar(
              message: l10n.localizeError(state.error),
              state: FlushBarState.error);
        } else if (state.state.isAdded) {
          context.showSnackBar(
              message: "Sakan Added",
              doBefore: () {
                context.pop();
                if (state.tempSakan != null) {
                  _addBuildedSakan(context, sakan: state.tempSakan!);
                }
              });
        }
      },
      listenWhen: (prev, curr) => prev.state != curr.state,
    );
  }

  void _addSakan(BuildContext context) =>
      context.read<SakanBuilderCubit>().addSakan();

  void _animatePages(int page) => pageController.jumpToPage(page);

  void _saveAndExit(BuildContext context) {
    context.read<SakanBuilderCubit>().saveCurrentState();
    context.pop();
  }

  void _onPageChanged(
    BuildContext context, {
    required int index,
  }) =>
      context.read<SakanBuilderCubit>().pageChanged(index);

  void _addBuildedSakan(
    BuildContext context, {
    required Sakan sakan,
  }) =>
      context.read<SakanCubit>().addBuildedSakanToCurrentSakans(sakan);
}
