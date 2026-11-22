// SPDX-FileCopyrightText: 2026 Délia Cheminot <delia@cheminot.net>
// SPDX-FileContributor: Frozzie "Frozzie89"
//
// SPDX-License-Identifier: AGPL-3.0-only

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mona/data/model/consumable_supply_item.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/ui/extensions/consumable_type_icon.dart';
import 'package:mona/ui/widgets/dropdowns/consumable_type_dropdown.dart';
import 'package:mona/ui/widgets/forms/form_dropdown_field.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/regex_patterns.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

class NewConsumableItemSpecificsPage extends StatefulWidget {
  final String name;

  const NewConsumableItemSpecificsPage({super.key, required this.name});

  @override
  State<NewConsumableItemSpecificsPage> createState() =>
      _NewConsumableItemSpecificsPageState();
}

class _NewConsumableItemSpecificsPageState
    extends State<NewConsumableItemSpecificsPage> {
  late TextEditingController _amountController;
  ConsumableType? _consumableType;

  String? get _amountError =>
      ConsumableSupplyItem.validateAmount(_amountController.text);
  String? get _consumableTypeError =>
      _consumableType == null ? t.requiredField : null;

  bool get _isFormValid => _amountError == null && _consumableTypeError == null;

  void _refresh() => setState(() {});

  void _closeAll() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  ConsumableSupplyItem _buildItem(ConsumableType type) {
    final name = widget.name;
    final amount = _amountController.text.toInt;
    OtherSupplyItem other(OtherSupplyType otherSupplyType) => OtherSupplyItem(
        name: name, amount: amount, otherSupplyType: otherSupplyType);
    return switch (type) {
      ConsumableType.syringe => Syringe(name: name, amount: amount),
      ConsumableType.needle => Needle(name: name, amount: amount),
      ConsumableType.wipe => other(OtherSupplyType.wipe),
      ConsumableType.gloves => other(OtherSupplyType.gloves),
      ConsumableType.bandage => other(OtherSupplyType.bandage),
    };
  }

  void _addItem() async {
    final item = _buildItem(_consumableType!);
    final created =
        await Provider.of<SupplyItemProvider>(context, listen: false).add(item);

    if (!mounted) return;
    Navigator.of(context)
      ..pop()
      ..pop(created);
  }

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModelForm(
      title: widget.name,
      avatar: _consumableType?.icon ?? Symbols.medication_rounded,
      submitButtonLabel: t.add,
      submitButtonKey: const ValueKey('newConsumableItemAdd'),
      isFormValid: _isFormValid,
      saveChanges: _addItem,
      closeAll: _closeAll,
      fields: [
        FormDropdownField<ConsumableType>(
          value: _consumableType,
          items: consumableTypeDropdownMenuItems(),
          onChanged: (value) => setState(() => _consumableType = value),
          label: t.supplyType,
        ),
        FormTextField(
          controller: _amountController,
          label: t.amount,
          fieldKey: const ValueKey('newConsumableItemAmount'),
          onChanged: _refresh,
          inputType: TextInputType.number,
          regexFormatter: RegexPatterns.intNumber,
        ),
      ],
    );
  }
}
