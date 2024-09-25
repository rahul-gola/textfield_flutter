import 'package:flutter/widgets.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    required this.child,
    required this.icon,
    required this.color,
    required this.iconSize,
    this.style,
    this.text,
    super.key,
  });

  final Widget child;
  final IconData icon;
  final double iconSize;
  final Color color;
  final TextStyle? style;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        if (text != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, color: color, size: iconSize),
              const SizedBox(width: 8),
              Text(text ?? '', style: style),
            ],
          ),
        ],
      ],
    );
  }
}