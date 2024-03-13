import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/custom_texfield.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import '../../features/echo/cubit/echo_cubit.dart';

class TextEditScreen extends StatefulWidget {
  final String title;
  final Widget? leading;
  final Widget? bottomSheet;
  final String actionText;
  final VoidCallback? onInit;

  final bool absorbing;
  final String hint;
  final bool loading;
  final VoidCallback? onAction;
  final void Function(String)? onChanged;

  const TextEditScreen({
    Key? key,
    required this.title,
    required this.absorbing,
    required this.actionText,
    required this.hint,
    this.leading,
    this.loading = false,
    required this.onAction,
    required this.onChanged,
    this.bottomSheet,
    this.onInit,
  }) : super(key: key);

  @override
  State<TextEditScreen> createState() => _TextEditScreenState();
}

class _TextEditScreenState extends State<TextEditScreen> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit!.call();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.absorbing,
      child: Scaffold(
        bottomSheet: widget.bottomSheet,
        appBar: AppBar(
            actions: [
              widget.loading
                  ? const Loader()
                  : TextButton(
                      onPressed: widget.onAction,
                      child: Text(widget.actionText)),
            ],
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(widget.title)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.leading != null) widget.leading!,
                CustomTextField(
                  textInputType: TextInputType.multiline,
                  action: TextInputAction.newline,
                  onSubmit: (v) => Navigator.pop(context),
                  filled: false,
                  autoFoucs: true,
                  isColumed: false,
                  onChanged: (v) => context.read<EchoCubit>().echoChanged(v),
                  isOutlined: false,
                  border: InputBorder.none,
                  hint: widget.hint,
                  focusedBorder: InputBorder.none,
                  hintStyle: context.bodyLarge.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
