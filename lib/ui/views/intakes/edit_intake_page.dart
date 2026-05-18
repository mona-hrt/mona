import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mona/controllers/medication_intake_manager.dart';
import 'package:mona/controllers/supply_item_manager.dart';
import 'package:mona/data/model/administration_route.dart';
import 'package:mona/data/model/medication_intake.dart';
import 'package:mona/data/model/medication_supply_item.dart';
import 'package:mona/data/model/supply_item.dart';
import 'package:mona/data/providers/medication_intake_provider.dart';
import 'package:mona/data/providers/supply_item_provider.dart';
import 'package:mona/l10n/build_context_extensions.dart';
import 'package:mona/l10n/helpers/supply_item_l10n.dart';
import 'package:mona/ui/widgets/dialogs.dart';
import 'package:mona/ui/widgets/dropdowns/injection_side_dropdown.dart';
import 'package:mona/ui/widgets/forms/form_datetime_field.dart';
import 'package:mona/ui/widgets/forms/form_dropdown_field.dart';
import 'package:mona/ui/widgets/forms/form_info_text.dart';
import 'package:mona/ui/widgets/forms/form_spacer.dart';
import 'package:mona/ui/widgets/forms/form_text_field.dart';
import 'package:mona/ui/widgets/forms/model_form.dart';
import 'package:mona/util/regex_patterns.dart';
import 'package:mona/util/string_parsing.dart';
import 'package:provider/provider.dart';

class EditIntakePage extends StatefulWidget {
  final MedicationIntake intake;

  EditIntakePage(this.intake);

  @override
  State<EditIntakePage> createState() => _EditIntakePageState();
}

class _EditIntakePageState extends State<EditIntakePage> {
  late DateTime _takenDate;
  bool _takenDateChanged = false;
  late TextEditingController _takenDoseController;
  late Decimal _takenDose;
  late Decimal _wastedAmount; // in mL
  late TextEditingController _wastedAmountController;
  InjectionSide? _selectedSide;
  bool _hasInitializedSide = false;
  SupplyItem? _selectedSupplyItem;
  bool _hasInitializedSupplyItem = false;
  late TextEditingController _notesController;

  String? get _takenDoseError =>
      MedicationIntake.validateDose(context.l10n, _takenDoseController.text);

  String? get _wastedAmountError => MedicationIntake.validateWastedAmount(
      context.l10n, _wastedAmountController.text);

  bool get _isFormValid => _takenDoseError == null;

  bool get _isInjection =>
      widget.intake.administrationRoute == AdministrationRoute.injection;

  void _editIntake(
      MedicationIntakeProvider medicationIntakeProvider,
      SupplyItemProvider supplyItemProvider,
      MedicationIntake intake,
      SupplyItem? newItem) async {
    if (!_isFormValid) return;
    if (!mounted) return;

    SupplyItem? previousItem =
        supplyItemProvider.getItemById(intake.supplyItemId);
    final previousMedication = previousItem as MedicationSupplyItem?;
    final newMedication = newItem as MedicationSupplyItem?;

    Decimal wastedDose = newMedication?.getDose(_wastedAmount) ?? Decimal.zero;
    Decimal usedDose = _takenDose + wastedDose;

    SupplyItemManager(supplyItemProvider).switchDoses(
        previousMedication, newMedication, intake.usedDose, usedDose);

    String? timezoneIdentifier = intake.takenTimeZone;
    if (_takenDateChanged) {
      final TimezoneInfo timezone = await FlutterTimezone.getLocalTimezone();
      timezoneIdentifier = timezone.identifier;
    }

    final String? notes =
        _notesController.text.isEmpty ? null : _notesController.text;

    MedicationIntake updatedIntake = intake.copyWith(
      takenDateTime: _takenDate.toUtc(),
      takenTimeZone: timezoneIdentifier,
      takenDose: _takenDose,
      wastedDose: wastedDose,
      side: _selectedSide,
      supplyItemId: newItem?.id,
      notes: notes,
    );

    medicationIntakeProvider.updateIntake(updatedIntake);

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _deleteIntake(
    MedicationIntakeProvider medicationIntakeProvider,
    SupplyItemProvider supplyItemProvider,
    MedicationIntake intake,
  ) async {
    if (!mounted) return;
    MedicationIntakeManager(medicationIntakeProvider, supplyItemProvider)
        .deleteIntake(intake);
    Navigator.of(context).pop();
  }

  void _onInjectionSideChanged(InjectionSide? side) {
    if (side != null) {
      setState(() {
        _selectedSide = side;
      });
    }
  }

  void _onTakenDateChanged(DateTime date) {
    setState(() {
      _takenDate = date;
      _takenDateChanged = true;
    });
  }

  void _onTakenDoseChanged() {
    final takenDose = _takenDoseController.text.toDecimalOrNull;

    if (takenDose != null) {
      setState(() {
        _takenDose = takenDose;
      });
    } else {
      setState(() {});
    }
  }

  void _onWastedAmountChanged() {
    final wasted = _wastedAmountController.text.toDecimalOrNull;

    if (wasted != null) {
      setState(() {
        _wastedAmount = wasted;
      });
    } else {
      setState(() {});
    }
  }

  void _onSupplyItemChanged(SupplyItem? item) {
    setState(() {
      _selectedSupplyItem = item;
    });
  }

  void _refresh() => setState(() {});

  Future<bool?> confirmDeleteIntake(BuildContext context) {
    return Dialogs.confirmDeleteDialog(
        context: context, title: context.l10n.deleteIntake);
  }

  @override
  void initState() {
    super.initState();
    _takenDate = widget.intake.takenDateTime?.toLocal() ?? DateTime.now();
    print(_takenDate);
    _takenDose = widget.intake.takenDose;
    MedicationSupplyItem? item = context
        .read<SupplyItemProvider>()
        .getItemById(widget.intake.supplyItemId) as MedicationSupplyItem?;
    _wastedAmount = item?.getAmount(widget.intake.wastedDose ?? Decimal.zero) ??
        Decimal.zero;
    _takenDoseController = TextEditingController(text: _takenDose.toString());
    _wastedAmountController =
        TextEditingController(text: _wastedAmount.toString() ?? '0');
    _notesController = TextEditingController(text: widget.intake.notes ?? '');
  }

  @override
  void dispose() {
    _takenDoseController.dispose();
    _wastedAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    return Consumer2<MedicationIntakeProvider, SupplyItemProvider>(
      builder: (context, medicationIntakeProvider, supplyItemProvider, child) {
        final bool isLoading =
            medicationIntakeProvider.isLoading || supplyItemProvider.isLoading;

        if (!isLoading && !_hasInitializedSide && _isInjection) {
          _selectedSide = widget.intake.side;
          _hasInitializedSide = true;
        }

        if (!isLoading && !_hasInitializedSupplyItem) {
          _selectedSupplyItem =
              supplyItemProvider.getItemById(widget.intake.supplyItemId);
          _hasInitializedSupplyItem = true;
        }

        final supplyItemOptions = supplyItemProvider.getItemsForMedication(
          widget.intake.molecule,
          widget.intake.administrationRoute,
          widget.intake.ester,
        );

        final supplyItemDropdownItems = [
          DropdownMenuItem<MedicationSupplyItem?>(
            value: null,
            child: Text(localizations.none),
          ),
          ...supplyItemOptions.map(
            (item) => DropdownMenuItem<MedicationSupplyItem?>(
              value: item,
              child: Text(item.name),
            ),
          ),
        ];

        return ModelForm(
          title: localizations.editIntake,
          avatar: widget.intake.administrationRoute.icon,
          submitButtonLabel: localizations.save,
          isFormValid: _isFormValid,
          saveChanges: (!isLoading && _isFormValid)
              ? () => _editIntake(medicationIntakeProvider, supplyItemProvider,
                  widget.intake, _selectedSupplyItem)
              : () {},
          onDelete: () async {
            final confirmed = await confirmDeleteIntake(context);
            if (confirmed == false) return;
            _deleteIntake(
                medicationIntakeProvider, supplyItemProvider, widget.intake);
          },
          fields: [
            FormDateTimeField(
              label: localizations.date,
              datetime: _takenDate,
              onChanged: _onTakenDateChanged,
            ),
            FormSpacer(),
            FormTextField(
              controller: _takenDoseController,
              label: localizations.takenAmount,
              onChanged: _onTakenDoseChanged,
              inputType: TextInputType.numberWithOptions(decimal: true),
              suffixText: widget.intake.molecule.unit,
              errorText: _takenDoseError,
              regexFormatter: RegexPatterns.floatNumber,
            ),
            FormTextField(
              controller: _wastedAmountController,
              label: localizations.wastedAmount,
              onChanged: _onWastedAmountChanged,
              inputType: TextInputType.numberWithOptions(decimal: true),
              suffixText: localizations.milliliters,
              errorText: _wastedAmountError,
              regexFormatter: RegexPatterns.floatNumber,
            ),
            if (_selectedSupplyItem case final MedicationSupplyItem supplyItem)
              FormInfoText(
                infoText: supplyItem.localizedSupplyAmount(
                  localizations,
                  _takenDose,
                  widget.intake.molecule.unit,
                ),
              ),
            FormSpacer(),
            FormDropdownField<SupplyItem?>(
              value: _selectedSupplyItem,
              items: supplyItemDropdownItems,
              onChanged: _onSupplyItemChanged,
              label: localizations.supplyItem,
            ),
            if (_isInjection)
              FormDropdownField<InjectionSide>(
                value: _selectedSide,
                items: injectionSideDropdownMenuItems(localizations),
                onChanged: _onInjectionSideChanged,
                label: localizations.injectionSide,
              ),
            FormSpacer(),
            FormTextField(
              controller: _notesController,
              label: localizations.notes,
              onChanged: _refresh,
              inputType: TextInputType.multiline,
              multiline: true,
            )
          ],
        );
      },
    );
  }
}
