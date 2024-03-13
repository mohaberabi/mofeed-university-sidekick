import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';

class CustomTimePicker extends StatelessWidget {
  final DateTime? initialTime;

  final DateTime? maximumTime;
  final int minutesInterval;
  final void Function(DateTime)? onTap;

  const CustomTimePicker({
    super.key,
    this.initialTime,
    this.maximumTime,
    this.minutesInterval = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final time = times()[index];
          return GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(time);
              } else {
                Navigator.pop(context, time);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                time.amPM,
                style: context.bodyLarge.copyWith(fontSize: 16),
              ),
            ),
          );
        },
        itemCount: times().length,
      ),
    );
  }

  List<DateTime> times() {
    final initTime = initialTime ?? DateTime.now();
    final time = initTime.copyWith(minute: 0);
    final minutes = (maximumTime ?? initTime.add(const Duration(hours: 5)))
        .difference(time)
        .inMinutes;
    final list = <DateTime>[];
    for (int i = minutesInterval; i < minutes; i += minutesInterval) {
      list.add(time.add(Duration(minutes: i)));
    }
    return list;
  }
}
