import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/theme_changer/cubit/theme_changer_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_cubit.dart';
import 'package:mofeed_shared/cubit/localization_cubit/local_states.dart';

class MofeedBuilder extends StatelessWidget {
  final Widget Function(ChangeLocalState, ThemeMode) builder;

  const MofeedBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, localState) {
      if (localState is ChangeLocalState) {
        return BlocBuilder<ThemeChangerCubit, ThemeMode>(
            builder: (context, state) {
          return builder(localState, state);
        });
      } else {
        return const SizedBox();
      }
    });
  }
}
