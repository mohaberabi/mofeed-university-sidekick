import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/echo/cubit/echo_cubit.dart';
import 'package:mofeduserpp/features/echo/cubit/echo_states.dart';
import 'package:mofeduserpp/features/echo/widgets/echo_widget.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/app_routes.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import '../../../core/services/service_lcoator.dart';

class EchoBuilder extends StatelessWidget {
  final bool getMine;

  const EchoBuilder({
    Key? key,
    this.getMine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider.value(
      value: context.read<EchoCubit>()..getAllEchos(getMine: getMine),
      child: BlocListener<EchoCubit, EchoState>(
          listener: (context, state) {
            state.status.when({
              EchoStatus.deleted: () {
                context.showSnackBar(message: l10n.echoWasRemoved);
              },
              EchoStatus.error: () {
                context.showSnackBar(
                    message: l10n.localizeError(state.error),
                    state: FlushBarState.error);
              },
              EchoStatus.posted: () => context.showSnackBar(
                  message: l10n.echoPosted, doBefore: () => context.pop()),
            });
          },
          listenWhen: (prev, curr) => prev.status != curr.status,
          child: BlocBuilder<EchoCubit, EchoState>(
            builder: (context, state) {
              final echos = state.echos;
              final populated = AppViewBuilder.list(
                seprator: (context, index) => const Divider(),
                onMax: () async => _getEchos(context),
                onRefresh: () async => _getEchos(context, clearBefore: true),
                builder: (context, index) {
                  final echo = state.echos.values.toList()[index];
                  return EchoWidget(
                    echo: echo,
                    showReplies: true,
                    onTap: () => context.navigateTo(
                        routeName: AppRoutes.echoRepliesScreen, args: echo),
                  );
                },
                count: echos.length,
                placeHolder: AppPlaceHolder.empty(
                    title: l10n.noEchosPosted, subtitle: l10n.noEchosSubtitle),
              );
              return state.status.builder({
                EchoStatus.loading: () => const Loader(),
                EchoStatus.error: () => AppPlaceHolder.error(
                    title: l10n.localizeError(state.error),
                    onTap: () => _getEchos(context, clearBefore: true)),
                EchoStatus.populated: () {
                  return populated;
                }
              }, placeHolder: populated);
            },
          )),
    );
  }

  void _getEchos(BuildContext context, {bool clearBefore = false}) => context
      .read<EchoCubit>()
      .getAllEchos(clearBefore: clearBefore, getMine: getMine);
}
