import 'package:flutter/material.dart';
import 'package:mofeduserpp/features/university/widgets/university_widget.dart';
import 'package:mofeed_shared/model/university_model.dart';

class UniversityChooser extends StatelessWidget {
  final void Function(UniversityModel) onChoosed;

  final List<UniversityModel> unis;
  final bool Function(UniversityModel) selected;

  const UniversityChooser({
    super.key,
    required this.onChoosed,
    required this.unis,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final uni = unis[index];
          return UniversityWidget.fromUni(
              selected: selected(uni),
              university: uni,
              onTap: () {
                onChoosed(uni);
              });
        },
        itemCount: unis.length,
      ),
    );
  }
}
