import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnterNumberDialog extends StatefulWidget {
  const EnterNumberDialog({
    super.key,
    this.currentValue,
    this.title,
  });

  final int? currentValue;
  final String? title;

  @override
  State<EnterNumberDialog> createState() => _EnterNumberDialogState();
}

class _EnterNumberDialogState extends State<EnterNumberDialog> {
  late TextEditingController controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.currentValue?.toString() ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dialogTitle = widget.title ?? l10n.addProgressTitle;

    return AlertDialog(
      title: Text(dialogTitle),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n.enterProgressLabel,
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.enterNumberEmptyError;
            }
            final number = int.tryParse(value);
            if (number == null || number < 0) {
              return l10n.enterNumberInvalidError;
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancelButton),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              final newValue = int.parse(controller.text);
              Navigator.of(context).pop(newValue);
            }
          },
          child: Text(l10n.okButton),
        ),
      ],
    );
  }
}
