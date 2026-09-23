import 'package:flutter/material.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/delivery_form.dart';
import 'package:mona/data/model/dosing_basis.dart';
import 'package:mona/data/model/ester.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/molecule.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/i18n/helpers/molecule_l10n.dart';
import 'package:mona/i18n/helpers/supply_item_l10n.dart';
import 'package:mona/i18n/translations.g.dart';
import 'package:mona/services/preferences_service.dart';
import 'package:mona/ui/widgets/dialogs.dart';
import 'package:mona/ui/widgets/dropdowns/administration_route_dropdown.dart';
import 'package:mona/ui/widgets/dropdowns/delivery_form_dropdown.dart';
import 'package:mona/ui/widgets/dropdowns/ester_dropdown.dart';
import 'package:mona/ui/widgets/dropdowns/molecule_dropdown.dart';
import 'package:mona/ui/widgets/forms/form_dropdown_field.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/regex_patterns.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

class EditItemPage extends StatefulWidget {
  final MedicationSupplyItem item;

  EditItemPage({required this.item});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController _totalAmountController;
  late TextEditingController _usedAmountController;
  late TextEditingController _dosePerUnitController;
  late TextEditingController _nameController;
  late Molecule _molecule;
  late AdministrationRoute _administrationRoute;
  late Ester? _ester;
  late DeliveryForm? _deliveryForm;
  late PreferencesService _preferencesService;
  late SupplyItemProvider _supplyItemProvider;

  String? get _nameError => SupplyItem.validateName(_nameController.text);

  String? get _totalAmountError =>
      MedicationSupplyItem.validateTotalAmount(_totalAmountController.text);

  String? get _usedAmountError {
    final validator =
        MedicationSupplyItem.usedAmountValidator(_totalAmountController.text);
    return validator(_usedAmountController.text);
  }

  String? get _dosePerUnitError =>
      MedicationSupplyItem.validateDosePerUnit(_dosePerUnitController.text);

  String? get _moleculeError =>
      MedicationSupplyItem.validateMolecule(_molecule);
  String? get _administrationRouteError =>
      MedicationSupplyItem.validateAdministrationRoute(_administrationRoute);
  String? get _esterError {
    final validator =
        MedicationSupplyItem.esterValidator(_molecule, _administrationRoute);
    return validator(_ester);
  }

  String get _unitLabel =>
      countUnitLabel(_administrationRoute, _deliveryForm, 1);

  String get _dosePerUnitLabel =>
      dosePerUnitFieldLabel(_administrationRoute, _deliveryForm);

  bool get _isFormValid =>
      _nameError == null &&
      _totalAmountError == null &&
      _usedAmountError == null &&
      _dosePerUnitError == null &&
      _moleculeError == null &&
      _administrationRouteError == null &&
      _esterError == null;

  bool get _useEsterField =>
      _molecule == KnownMolecules.estradiol &&
      _administrationRoute == AdministrationRoute.injection;

  void _onMoleculeChanged(Molecule? molecule) {
    if (molecule != null) {
      setState(() {
        _molecule = molecule;

        if (!_useEsterField) {
          _ester = null;
        }
      });
    }
  }

  void _onAdministrationRouteChanged(AdministrationRoute? administrationRoute) {
    if (administrationRoute != null) {
      setState(() {
        _administrationRoute = administrationRoute;

        if (administrationRoute == AdministrationRoute.gel) {
          _deliveryForm ??= DeliveryForm.pump;
        } else {
          _deliveryForm = null;
        }

        if (!_useEsterField) {
          _ester = null;
        }
      });
    }
  }

  void _onEsterChanged(Ester? ester) {
    if (ester != null) {
      setState(() {
        _ester = ester;
      });
    }
  }

  void _onDeliveryFormChanged(DeliveryForm? deliveryForm) {
    if (deliveryForm != null) {
      setState(() {
        _deliveryForm = deliveryForm;
      });
    }
  }

  void _refresh() => setState(() {});

  void _saveChanges() {
    if (!_isFormValid) return;
    if (!mounted) return;

    final dosePerUnit = _dosePerUnitController.text.toDecimal;
    final totalDose = dosePerUnit * _totalAmountController.text.toDecimal;
    final usedDose = dosePerUnit * _usedAmountController.text.toDecimal;
    final ester = _useEsterField ? _ester : null;

    final updatedItem = widget.item.copyWith(
      name: _nameController.text,
      totalDose: totalDose,
      dosePerUnit: dosePerUnit,
      usedDose: usedDose,
      molecule: _molecule,
      administrationRoute: _administrationRoute,
      ester: ester,
      deliveryForm: _deliveryForm,
    );
    _supplyItemProvider.updateItem(updatedItem);

    Navigator.of(context).pop();
  }

  Future<void> _confirmDelete() async {
    final confirmed = await Dialogs.confirmDeleteDialog(
      context: context,
      title: t.deleteItem(name: widget.item.name),
    );

    if (confirmed == true) {
      if (!mounted) return;
      _supplyItemProvider.deleteItem(widget.item);
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    final totalAmountText =
        widget.item.getAmount(widget.item.totalDose).toString();
    final usedAmountText =
        widget.item.getAmount(widget.item.usedDose).toString();
    _totalAmountController = TextEditingController(text: totalAmountText);
    _usedAmountController = TextEditingController(text: usedAmountText);
    _dosePerUnitController =
        TextEditingController(text: widget.item.dosePerUnit.toString());
    _nameController = TextEditingController(text: widget.item.name);
    _molecule = widget.item.molecule;
    _administrationRoute = widget.item.administrationRoute;
    _ester = widget.item.ester;
    _deliveryForm = widget.item.deliveryForm;
    _supplyItemProvider =
        Provider.of<SupplyItemProvider>(context, listen: false);
    _preferencesService =
        Provider.of<PreferencesService>(context, listen: false);
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _usedAmountController.dispose();
    _dosePerUnitController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModelForm(
      title: t.editItem,
      avatar: _administrationRoute.icon,
      submitButtonLabel: t.save,
      submitButtonKey: const ValueKey('editItemSave'),
      deleteButtonKey: const ValueKey('editItemDelete'),
      isFormValid: _isFormValid,
      saveChanges: _saveChanges,
      onDelete: _confirmDelete,
      fields: [
        FormTextField(
          controller: _nameController,
          label: t.name,
          fieldKey: const ValueKey('editItemName'),
          onChanged: _refresh,
          inputType: TextInputType.text,
          errorText: _nameError,
        ),
        FormSpacer(),
        FormDropdownField<Molecule>(
          value: _molecule,
          items: moleculeDropdownMenuItems(_preferencesService.allMolecules),
          onChanged: _onMoleculeChanged,
          label: t.molecule,
        ),
        FormDropdownField<AdministrationRoute>(
          value: _administrationRoute,
          items: administrationRouteDropdownMenuItems(),
          onChanged: _onAdministrationRouteChanged,
          label: t.adminRoute,
        ),
        if (_administrationRoute == AdministrationRoute.gel)
          FormDropdownField<DeliveryForm>(
            value: _deliveryForm,
            items: deliveryFormDropdownMenuItems(),
            onChanged: _onDeliveryFormChanged,
            label: t.deliveryForm,
          ),
        if (_useEsterField)
          FormDropdownField<Ester>(
            value: _ester,
            items: esterDropdownMenuItems(),
            onChanged: _onEsterChanged,
            label: t.ester,
          ),
        FormSpacer(),
        FormTextField(
            controller: _totalAmountController,
            label: t.totalAmount,
            onChanged: _refresh,
            inputType: TextInputType.numberWithOptions(decimal: true),
            suffixText: _unitLabel,
            errorText: _totalAmountError,
            regexFormatter: RegexPatterns.floatNumber),
        FormTextField(
            controller: _usedAmountController,
            label: t.usedAmount,
            onChanged: _refresh,
            inputType: TextInputType.numberWithOptions(decimal: true),
            suffixText: _unitLabel,
            errorText: _usedAmountError,
            regexFormatter: RegexPatterns.floatNumber),
        FormTextField(
          controller: _dosePerUnitController,
          label: _dosePerUnitLabel,
          onChanged: _refresh,
          inputType: TextInputType.numberWithOptions(decimal: true),
          suffixText:
              '${_molecule.localizedUnit(DosingBasis.mass)}/$_unitLabel',
          errorText: _dosePerUnitError,
          regexFormatter: RegexPatterns.floatNumber,
        ),
      ],
    );
  }
}
