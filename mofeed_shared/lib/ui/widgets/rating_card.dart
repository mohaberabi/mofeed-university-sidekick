import 'package:flutter/material.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/ui/widgets/rating_builder.dart';

import '../../model/rating_model.dart';

class RatingCard extends StatelessWidget {
  final RatingModel rating;

  const RatingCard({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBuilder(
            value: rating.value,
            length: rating.value,
            expand: false,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            rating.username,
            style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          if (rating.text.isNotEmpty)
            Text(
              rating.text,
              style: context.bodyLarge.copyWith(
                  color: context.bodyLarge.color!.withOpacity(0.85),
                  height: 1.75),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                rating.createdAt.mDy,
                style: context.bodyLarge.copyWith(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
