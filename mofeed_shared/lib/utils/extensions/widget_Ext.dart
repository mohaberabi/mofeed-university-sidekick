import 'package:flutter/material.dart';

extension Sliverable on Widget {
  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(child: this);
}

// extension NumToSizedBox on num {
//   Widget get height => SizedBox(height: toDouble());
//
//   Widget get width => SizedBox(width: toDouble());
// }

extension Themer on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension MaterialPageRouter on Widget {
  Route get toMaterialRoute => MaterialPageRoute(builder: (_) => this);
}
