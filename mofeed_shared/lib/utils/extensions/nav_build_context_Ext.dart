import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

import '../../constants/const_methods.dart';

extension NavEasy on BuildContext {
  void pop() => Navigator.pop(this);

  Future<void> showSnackBar({
    required String message,
    Widget? button,
    FlushBarState state = FlushBarState.done,
    void Function()? whenClosed,
    void Function()? doBefore,
  }) async {
    if (doBefore != null) {
      doBefore.call();
    }
    final fl = Flushbar<void>(
      titleColor: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: state.color,
      isDismissible: true,
      shouldIconPulse: false,
      duration: const Duration(seconds: 4),
      icon: Icon(state.icon, color: Colors.white),
      mainButton: button,
      messageText: Text(
        message,
        style: bodyLarge.copyWith(color: Colors.white, fontSize: 15),
      ),
    );
    await fl.show(this).then((value) {
      if (whenClosed != null) {
        whenClosed.call();
      }
    });
  }

  Future<T?> navigateTo<T extends Object>({
    required String routeName,
    Object? args,
    Function? doBefore,
  }) async {
    if (doBefore != null) {
      doBefore();
    }
    return await Navigator.pushNamedAndRemoveUntil(
        this, routeName, (route) => true,
        arguments: args);
  }

  void showAppSheet({
    required Widget child,
    double? elevation,
    bool scrollable = false,
    bool dismissable = true,
    bool useSafeArea = true,
    bool dragable = true,
    String? title,
    TextStyle? titleStyle,
    bool expanded = true,
    EdgeInsets? padding,
  }) {
    showModalBottomSheet(
        isDismissible: dismissable,
        backgroundColor: Colors.white,
        isScrollControlled: scrollable,
        enableDrag: dragable,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        useSafeArea: useSafeArea,
        shape: theme.primaryOutlineBorder,
        context: this,
        builder: (context) {
          return Padding(
            padding: padding ?? const EdgeInsets.only(right: 16, left: 16),
            child: Container(
              color: theme.scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title != null
                          ? Text(title, style: titleStyle ?? context.titleLarge)
                          : const SizedBox(),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close)),
                    ],
                  ),
                  expanded
                      ? Expanded(
                          child: child,
                        )
                      : child,
                ],
              ),
            ),
          );
        });
  }

  void navigateAndKeep({
    required String routeName,
    Object? args,
    required bool Function(Route<dynamic>) predicate,
  }) {
    Navigator.pushNamedAndRemoveUntil(this, routeName, predicate,
        arguments: args);
  }

  void navigateAndFinish({required String routeName, Object? args}) {
    Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false,
        arguments: args);
  }

  Future<DateTime?> showAdaptiveDatePicker() async {
    final now = DateTime.now();
    final tempDate = DateTime.now()
      ..add(const Duration(days: 1)).copyWith(hour: 09, minute: 30);
    late DateTime? picked;
    if (Platform.isAndroid) {
      picked = await showDatePicker(
          context: this,
          initialDate: now,
          firstDate: DateTime.now(),
          lastDate: now.add(const Duration(days: 30)));
    } else {
      DateTime _changedDateTime = now;
      picked = await showCupertinoModalPopup<DateTime>(
        context: this,
        builder: (context) {
          return CupertinoActionSheet(
            cancelButton: CupertinoButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context, null)),
            actions: [
              SizedBox(
                height: 225,
                child: CupertinoDatePicker(
                  minimumDate: tempDate,
                  maximumYear: DateTime.now().year,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    _changedDateTime = newDate;
                  },
                ),
              ),
              CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context, _changedDateTime),
                  child: const Text("Save"))
            ],
            message: const Text("Select Date"),
          );
        },
      );
    }
    return picked;
  }
}
