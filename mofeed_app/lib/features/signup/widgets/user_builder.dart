import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/profile/cubit/profile_state.dart';
import 'package:mofeed_shared/model/client_user_model.dart';

import '../../profile/cubit/profile_cubit.dart';

class UserBuilder extends StatelessWidget {
  final Widget Function(ClientUser) builder;

  const UserBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      final user = state.user;
      if (user == ClientUser.anonymus) {
        return const SizedBox();
      } else {
        return builder(user);
      }
    });
  }
}
