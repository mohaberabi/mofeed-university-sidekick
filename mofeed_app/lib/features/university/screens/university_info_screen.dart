import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/university/cubit/university_cubit.dart';
import 'package:mofeduserpp/features/university/cubit/university_state.dart';
import 'package:mofeduserpp/features/university/widgets/university_widget.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/conditioner.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class UnivresityInfoScreen extends StatelessWidget {
  const UnivresityInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider.value(
      value: context.read<UniversityCubit>()..getMyUni(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.universityInfo)),
        body: BlocBuilder<UniversityCubit, UniversityState>(
          builder: (context, state) {
            return state.state.child(
              doneChild: Conditioner(
                  condition: state.myUniversity == null,
                  builder: (noUni) {
                    if (noUni) {
                      return AppPlaceHolder.error(
                          title: l10n.localizeError(state.error),
                          onTap: () =>
                              context.read<UniversityCubit>().getMyUni());
                    } else {
                      final uni = state.myUniversity!;
                      return Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: UniversityWidget.fromUni(university: uni),
                      );
                    }
                  }),
              errorChild: AppPlaceHolder.error(
                  onTap: () => context.read<UniversityCubit>().getMyUni(),
                  title: l10n.localizeError(state.error)),
              loadingChild: const Loader(),
            );
          },
        ),
      ),
    );
  }
}
