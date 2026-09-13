import 'package:flutter/material.dart';

class TintedSwitchTile extends StatelessWidget {
  const TintedSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SwitchListTile(
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        value: value,
        tileColor: value
            ? Theme.of(context).colorScheme.primaryContainer.withValues(
                  alpha: 0.4,
                )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onChanged: onChanged,
      ),
    );
  }
}
