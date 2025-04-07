import 'package:flutter/material.dart';

class CustomDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double iconSize;

  const CustomDetailRow({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.grey,
    this.iconSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        Text(text),
      ],
    );
  }
}
