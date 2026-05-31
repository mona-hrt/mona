import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/ui/views/supplies/new_generic_item_specifics_page.dart';
import 'package:mona/ui/views/supplies/new_medication_item_specifics_page.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';

enum _ItemType { medication, genericSupply }

class NewItemPage extends StatefulWidget {
  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  late TextEditingController _nameController;
  _ItemType _type = _ItemType.medication;

  String? get _nameError =>
      SupplyItem.validateName(context.l10n, _nameController.text);

  bool get _isFormValid => _nameError == null;

  void _refresh() => setState(() {});

  void _next() {
    final name = _nameController.text;

    final route = switch (_type) {
      _ItemType.medication => MaterialPageRoute<void>(
          builder: (context) => NewMedicationItemSpecificsPage(name: name),
        ),
      _ItemType.genericSupply => MaterialPageRoute<void>(
          builder: (context) => NewGenericItemSpecificsPage(name: name),
        ),
    };
    Navigator.of(context).push(route);
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    return ModelForm(
      title: localizations.newItem,
      submitButtonLabel: localizations.next,
      isFormValid: _isFormValid,
      saveChanges: _next,
      fields: [
        FormTextField(
          controller: _nameController,
          label: localizations.name,
          onChanged: _refresh,
          inputType: TextInputType.text,
        ),
        FormSpacer(),
        _typeToggle(),
      ],
    );
  }

  Widget _typeToggle() {
    return M3EToggleButtonGroup(
      type: M3EButtonGroupType.standard,
      size: M3EButtonSize.md,
      selectedIndex: _type.index,
      onSelectedIndexChanged: (index) {
        if (index == null) return;
        setState(() {
          _type = _ItemType.values[index];
        });
      },
      actions: const [
        M3EToggleButtonGroupAction(label: Text('Medication')),
        M3EToggleButtonGroupAction(label: Text('Generic supply')),
      ],
    );
  }
}
