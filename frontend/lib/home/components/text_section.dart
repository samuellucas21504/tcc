import 'package:flutter/material.dart';
import 'package:tcc/home/components/texts/description_text.dart';
import 'package:tcc/home/components/texts/title_text.dart';

class TextSection extends StatelessWidget {
  final String title;
  final String description;

  const TextSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(title),
          const SizedBox(height: 12),
          DescriptionText(description),
        ],
      ),
    );
  }
}
