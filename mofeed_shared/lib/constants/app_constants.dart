import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mofeed_shared/model/app_address.dart';

import '../ui/widgets/loader.dart';

int generateRandom16Digits() {
  Random random = Random();
  int maxDigits = 16;
  int randomNumber = (random.nextDouble() * pow(10, maxDigits)).toInt();
  return randomNumber;
}

void testPrint(Object? error, [StackTrace? stackTrace]) {
  debugPrintStack(stackTrace: stackTrace);
  debugPrint(error.toString());
}

int countStringlines(String text) {
  List<String> lines = text.split('\n');
  return lines.length;
}

class LoaderDialog extends StatelessWidget {
  const LoaderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: const Center(child: Loader()),
      ),
    );
  }
}

void showLoader(context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => LoaderDialog());
const tempAddress = AppAddress(
    name: "Cairo, egypt", subName: "New Cairo City", lat: 30, lng: 30);
