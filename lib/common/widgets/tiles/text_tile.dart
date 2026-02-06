import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TextTile extends StatelessWidget {
  const TextTile({
    super.key,
    required this.text,
    this.suffix,
    required this.showIcon,
    this.iconColor,
    this.size,
    this.onPressed,
  });

  final String text;
  final bool showIcon;
  final Widget? suffix;
  final Color? iconColor;
  final double? size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: Theme.of(context).textTheme.headlineMedium),
        Spacer(),
        showIcon
            ? TextButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                iconSize: size ?? 25,
                iconColor: Colors.blueAccent,
                textStyle: TextStyle(
                  color: iconColor ?? Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: suffix!,
            )
            : Container(),
      ],
    );
  }
}
