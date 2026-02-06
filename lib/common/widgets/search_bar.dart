import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/data/services/shared_preferences_service.dart';

import '../../provider.dart';

class ASearchBarTextField extends StatelessWidget {
  const ASearchBarTextField({
    super.key,
    required this.searchController,
    required this.ref,
    this.contentPadding = 20.0,
    this.borderRadius = 30.0,
    this.onChange = false,
    this.keepHistory = false,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    required this.hintText,
  });

  final TextEditingController searchController;
  final WidgetRef ref;
  final double borderRadius;
  final double contentPadding;
  final bool onChange;
  final bool keepHistory;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        contentPadding: EdgeInsets.all(contentPadding),
        suffixIcon: suffixIcon,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffix: suffix,
        prefix: prefix,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged:
          onChange
              ? (value) => ref.read(taskProvider).changeSearchText(value)
              : null,
      onSubmitted:
          onChange
              ? null
              : (value) {
                ref.read(taskProvider).changeSearchText(value);
                if (keepHistory) {
                  SharedPreferencesService().addSearchQuery(value);
                }
              },
    );
  }
}
