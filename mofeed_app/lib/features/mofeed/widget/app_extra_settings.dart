import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/login/cubit/login_cubit.dart';
import 'package:mofeed_shared/ui/widgets/platfom_dialog.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class AppExtraSettings extends StatelessWidget {
  const AppExtraSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton.icon(
              onPressed: () {
                showPlatformDialog(context,
                    dismissable: false,
                    title: l10n.signOutQ,
                    actions: [
                      DialogAction(
                        onTap: () => Navigator.pop(context),
                        title: l10n.discard,
                      ),
                      DialogAction(
                          onTap: () => context.read<LoginCubit>().signOut(),
                          title: l10n.signOut),
                    ],
                    subtitle: l10n.signOutExplain);
              },
              icon: const Icon(Icons.logout_outlined, color: Colors.red),
              label: Text(
                l10n.signOut,
                style: context.button.copyWith(color: Colors.red),
              )),
        ],
      ),
    );
  }
}
