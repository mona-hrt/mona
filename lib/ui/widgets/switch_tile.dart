import 'package:flutter/material.dart';

class SwitchTile extends StatelessWidget {
  const SwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.tintEnabled = true,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool tintEnabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SwitchListTile(
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        value: value,
        tileColor: value && tintEnabled
            ? Theme.of(context).colorScheme.primaryContainer.withValues(
                  alpha: 0.4,
                )
            : null,
        onChanged: onChanged,
      ),
    );
  }
}
