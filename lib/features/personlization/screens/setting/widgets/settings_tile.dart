import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_function.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
  });

  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Spacer(),
        IconButton(
          onPressed: onPressed,
          iconSize: 20,
          alignment: Alignment.center,
          icon: Icon(icon ?? Iconsax.arrow_right),
        ),
      ],
    );
  }
}
