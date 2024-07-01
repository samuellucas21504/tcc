import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.handleAccept,
    required this.handleRefuse,
  });

  final String title;
  final String subTitle;
  final VoidCallback handleAccept;
  final VoidCallback handleRefuse;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    print("@a $width");

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        constraints: const BoxConstraints(
          minHeight: 60,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.surface),
          color: colorScheme.surface,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            IconButton(onPressed: handleAccept, icon: const Icon(Icons.check)),
            IconButton(onPressed: handleRefuse, icon: const Icon(Icons.close)),
          ],
        ),
      );
    });
  }
}
