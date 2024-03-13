import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

import '../colors/app_colors.dart';

class ReadMore extends StatefulWidget {
  final int maxLines;
  final TextStyle? style;
  final String data;
  final TextStyle? readMoreStyle;
  final double? height;

  const ReadMore(this.data,
      {super.key,
      this.style,
      this.maxLines = 16,
      this.readMoreStyle,
      this.height});

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  int characters = 1;
  bool canExpand = false;
  int? maxLines;

  @override
  void initState() {
    characters = widget.data.characters.length;
    _init();
    super.initState();
  }

  void _init() {
    if (characters > 1000) {
      setState(() {
        canExpand = true;
        maxLines = widget.maxLines;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: Text(
            widget.data,
            style: widget.style ?? context.bodyLarge,
            maxLines: maxLines,
          ),
        ),
        if (canExpand)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (maxLines == null) {
                      maxLines = widget.maxLines;
                    } else {
                      maxLines = null;
                    }
                  });
                },
                child: Text(
                  maxLines == null ? 'Read Less' : 'Read More',
                  style: widget.readMoreStyle ??
                      context.bodyMedium.copyWith(color: AppColors.primColor),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
