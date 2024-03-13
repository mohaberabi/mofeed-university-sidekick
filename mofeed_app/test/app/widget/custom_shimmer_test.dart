// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mofeed_shared/ui/widgets/custom_shimmer.dart';
//
// void main() {
//   group("customshimmerTes ", () {
//     testWidgets("renders correctly", (tester) async {
//       await tester.pumpApp(const CustomShimmer());
//       expect(find.byType(CustomShimmer), findsOneWidget);
//     });
//
//     testWidgets("renders correctly with custom parameter", (tester) async {
//       const shimemr = CustomShimmer(
//         shape: BoxShape.circle,
//         h: 100,
//         w: 100,
//         highlightColor: Colors.red,
//         baseColor: Colors.black,
//         rounded: true,
//         child: Text("mohab"),
//       );
//       await tester.pumpApp(shimemr);
//       expect(find.byType(CustomShimmer), findsOneWidget);
//       expect(find.text("mohab"), findsOneWidget);
//       expect(shimemr.baseColor, Colors.black);
//       expect(shimemr.h, 100);
//       expect(shimemr.w, 100);
//     });
//   });
// }
