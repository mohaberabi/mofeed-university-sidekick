import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeduserpp/features/address/cubit/address_cubit.dart';
import 'package:mofeduserpp/features/address/cubit/address_state.dart';
import 'package:mofeed_shared/model/app_address.dart';
import 'package:mofeed_shared/ui/widgets/app_view_builder.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';

class SearchAddressScreen extends StatelessWidget {
  const SearchAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              hint: "Search for places",
              filled: false,
              isColumed: false,
              onSubmit: (v) => context.read<AddressCubit>().getAddresess(),
              collapsed: true,
              onChanged: (v) => context.read<AddressCubit>().queryChanged(v),
            ),
          ),
          Expanded(
            child: BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
              return state.state.builder(
                {
                  AddressStatus.loading: () => const Loader(),
                  AddressStatus.error: () => AppPlaceHolder.error(onTap: () {}),
                  AddressStatus.populated: () => AppViewBuilder.list(
                        seprator: (c, i) => const Divider(thickness: 0.5),
                        builder: (context, index) {
                          final address = state.addresses[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: ListTile(
                              onTap: () {
                                context.read<AddressCubit>().clear();
                                Navigator.pop(context,
                                    AppAddress.fromAutoComplete(address));
                              },
                              title: Text(address.name),
                              subtitle: Text(address.displayName),
                            ),
                          );
                        },
                        count: state.addresses.length,
                        placeHolder: const SizedBox(),
                      ),
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
