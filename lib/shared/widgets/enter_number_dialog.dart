import 'package:flutter/material.dart';

class EnterNumberDialog extends StatefulWidget {
  const EnterNumberDialog(
      {super.key, this.currentValue, this.title = 'Add Progress'});
  final int? currentValue;
  final String title;

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
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
              labelText: widget.title, border: OutlineInputBorder()),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a value';
            }
            final number = int.tryParse(value);
            if (number == null || number < 0) {
              return 'Enter a valid number';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              final newValue = int.parse(controller.text);
              Navigator.of(context).pop(newValue);
            }
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
