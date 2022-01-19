import 'package:flutter/material.dart';
import 'adaptive_button.dart';
import 'adaptive_text_field.dart';
import 'adaptive_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                  bottom: (10 + MediaQuery.of(context).viewInsets.bottom),
                ),
                child: Column(
                  children: <Widget>[
                    AdaptiveTextField(
                      label: 'Título',
                      controller: _titleController,
                      onSubmitted: (_) => _submitForm(),
                    ),
                    AdaptiveTextField(
                      label: 'Valor (R\$)',
                      controller: _valueController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onSubmitted: (_) => _submitForm,
                    ),
                    AdaptativeDatePicker(
                      selectedDate: _selectedDate,
                      onDateChanged: (newDate) {
                        setState(() {
                          _selectedDate = newDate;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AdaptiveButton(
                          label: 'Nova Transação',
                          onPressed: _submitForm,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}