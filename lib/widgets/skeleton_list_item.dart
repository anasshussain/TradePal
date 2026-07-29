import 'package:flutter/material.dart';

class SkeletonListItem extends StatelessWidget {
  final Widget leading;
  final List<Widget> lines;
  final EdgeInsetsGeometry padding;
  final Decoration? decoration;
  final double lineSpacing;

  const SkeletonListItem({
    super.key,
    required this.leading,
    required this.lines,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.lineSpacing = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < lines.length; i++) ...[
                    if (i != 0) SizedBox(height: lineSpacing),
                    lines[i],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}