import 'package:flutter/material.dart';
import '../res/theme.dart';

class NamedHorizontalDivider extends StatelessWidget {
  final String name;
  final TextStyle? textStyle;
  final double thickness;
  final Color color;
  final double padding;
  final VoidCallback? onTap;

  const NamedHorizontalDivider(
      {super.key,
      required this.name,
      this.textStyle,
      this.thickness = 1.0,
      this.color = AppTheme.neptune300,
      this.padding = 8.0,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: textStyle ??
              const TextStyle(fontSize: 16, color: AppTheme.lightAqua),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: padding),
            child: Divider(
              thickness: thickness,
              color: color,
            ),
          ),
        ),
        onTap != null
            ? IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.keyboard_double_arrow_right))
            : IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_double_arrow_left))
      ],
    );
  }
}
