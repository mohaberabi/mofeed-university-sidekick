import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../colors/app_colors.dart';
import '../spacing/spacing.dart';

class SenderWidget extends StatefulWidget {
  final void Function(String) onSend;
  final bool canSend;
  final void Function(String) onChanged;

  const SenderWidget({
    Key? key,
    required this.onSend,
    required this.canSend,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SenderWidget> createState() => _SenderWidgetState();
}

class _SenderWidgetState extends State<SenderWidget> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                constraints:
                    const BoxConstraints(maxHeight: 100, minHeight: 38),
                decoration: BoxDecoration(
                    borderRadius: 20.circle, color: context.theme.shadowColor),
                child: TextFormField(
                  onChanged: widget.onChanged,
                  cursorColor: AppColors.primColor,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  cursorHeight: 20,
                  style: context.bodyLarge,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: context.bodyLarge,
                      isCollapsed: true,
                      hintText: "Type a message...",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  controller: textEditingController,
                ),
              ),
            ),
          ),
          if (widget.canSend)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: GestureDetector(
                  onTap: () {
                    textEditingController.clear();
                    widget.onSend(textEditingController.text);
                  },
                  child: const CircleAvatar(
                      backgroundColor: AppColors.primColor,
                      radius: 18,
                      child: Icon(Icons.send_rounded,
                          color: Colors.white, size: 18))),
            )
        ],
      ),
    );
  }
}
