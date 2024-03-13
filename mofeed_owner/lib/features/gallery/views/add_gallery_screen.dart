import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_owner/features/gallery/cubit/gallery_cubit.dart';
import 'package:mofeed_owner/features/gallery/cubit/gallery_state.dart';
import 'package:mofeed_shared/utils/const_methods.dart';
import 'package:mofeed_shared/widgets/file_iamge.dart';
import 'package:mofeed_shared/widgets/loader.dart';
import 'package:mofeed_shared/widgets/primary_button.dart';

class AddGalleryScreen extends StatelessWidget {
  const AddGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GalleryCubit, GalleryState>(
      listener: (context, state) {
        state.state.when(
            error: () => showSnackBar(context,
                message: state.error, state: FlushBarState.error),
            done: () => showSnackBar(context,
                message: "Gallery uploaded",
                doBefore: () => Navigator.pop(context)),
            loading: () {});
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => context.read<GalleryCubit>().pickImages(),
                icon: const Icon(Icons.upload)),
          ],
          title: Text("Add gallery"),
        ),
        body:
            BlocBuilder<GalleryCubit, GalleryState>(builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.files.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final xfile = state.files[index];
                    return CustomFileImage.fromXfile(
                      xFile: xfile,
                      w: 200,
                      h: 200,
                    );
                  },
                ),
              ),
              state.state.loadingOrElse(
                whenLoading: const Loader(),
                orElse: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    onPress: state.readyUpload
                        ? () => context.read<GalleryCubit>().uploadImages()
                        : null,
                    label: "Upload",
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
