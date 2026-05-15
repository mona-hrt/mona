import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/ui/constants/dimensions.dart';
import 'package:mona/ui/widgets/forms/dismiss_keyboard_single_child_scroll_view.dart';

class ModelForm extends StatelessWidget {
  final String title;
  final IconData? avatar;
  final List<Widget> fields;
  final VoidCallback? onDelete;
  final VoidCallback? closeAll;
  final bool isFormValid;
  final VoidCallback saveChanges;
  final String submitButtonLabel;

  const ModelForm({
    required this.title,
    this.avatar,
    required this.fields,
    this.onDelete,
    this.closeAll,
    required this.isFormValid,
    required this.saveChanges,
    required this.submitButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (closeAll != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: closeAll,
            ),
        ],
      ),
      body: SafeArea(
        child: DismissKeyboardSingleChildScrollView(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (avatar != null) ...[
                const SizedBox(height: 32),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    child: Icon(avatar, size: 64),
                  ),
                ),
                const SizedBox(height: 32),
              ],
              ...fields,
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: borderPadding,
            left: borderPadding,
            right: borderPadding,
            bottom: borderPadding,
          ),
          child: Row(
            children: [
              if (onDelete != null) ...[
                Expanded(
                  child: M3EButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete),
                    label: Text(context.l10n.delete),
                    style: M3EButtonStyle.outlined,
                    size: M3EButtonSize.md,
                    decoration: M3EButtonDecoration(
                      foregroundColor:
                          WidgetStatePropertyAll(theme.colorScheme.error),
                      side: WidgetStatePropertyAll(
                          BorderSide(color: theme.colorScheme.error)),
                    ),
                  ),
                ),
                const SizedBox(width: borderPadding),
              ],
              Expanded(
                child: onDelete != null
                    ? M3EButton.icon(
                        onPressed: isFormValid ? saveChanges : null,
                        icon: const Icon(Icons.save),
                        label: Text(submitButtonLabel),
                        style: M3EButtonStyle.filled,
                        size: M3EButtonSize.md,
                      )
                    : M3EButton(
                        onPressed: isFormValid ? saveChanges : null,
                        style: M3EButtonStyle.filled,
                        size: M3EButtonSize.md,
                        child: Text(submitButtonLabel),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
