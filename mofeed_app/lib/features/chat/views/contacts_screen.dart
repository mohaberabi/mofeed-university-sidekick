import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_cubit.dart';
import 'package:mofeduserpp/features/chat/cubit/chat_states.dart';
import 'package:mofeduserpp/features/chat/widget/contact_card.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        return AppViewBuilder.list(
            seprator: (context, index) => const SizedBox(height: AppSpacing.lg),
            builder: (context, index) {
              final chat = state.chats[index];
              return ContactCard(chat: chat);
            },
            count: state.chats.length,
            placeHolder: AppPlaceHolder.empty(title: l10n.noChatsYet));
      },
    );
  }
}
