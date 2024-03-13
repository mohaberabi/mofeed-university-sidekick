import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/notifications/cubit/notification_state.dart';
import 'package:mofeduserpp/features/notifications/cubit/notifications_cubit.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with WidgetsBindingObserver {
  late NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();
    notificationCubit = context.read<NotificationCubit>()..getSubscribedTopic();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.notifications)),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return state.state.buildWhen(
              onLoading: () => const Loader(),
              onError: () => AppPlaceHolder.error(onTap: () {}),
              onDone: () {
                return ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                      subtitle: Text(l10n.recieveWhenNewEcho,
                          style: context.bodyLarge),
                      title: Text(l10n.recieveNotiUpdates,
                          style: context.titleLarge),
                      value: state.isSubscribed,
                      onChanged: (v) => notificationCubit.subscribe(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ListTile(
                      onTap: () => notificationCubit.openAppSettings(),
                      shape: context.theme.primaryOutlineBorder,
                      subtitleTextStyle: context.bodyLarge,
                      titleTextStyle: context.titleLarge,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                      subtitle: Text(l10n.manageNotiFromSettingsSubtitl),
                      title: Text(l10n.manageNotiFromSettingsTitle),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,
                          size: 16),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
