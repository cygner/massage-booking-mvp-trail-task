import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateTimeSelected;

  const DateTimePicker({
    super.key,
    required this.initialDate,
    required this.onDateTimeSelected,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedTime = TimeOfDay.fromDateTime(widget.initialDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Date picker button
        ListTile(
          title: const Text('Date'),
          subtitle: Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
          trailing: const Icon(Icons.calendar_today),
          onTap: () => _selectDate(context),
        ),

        const Divider(),

        // Time picker button
        ListTile(
          title: const Text('Time'),
          subtitle: Text(_selectedTime.format(context)),
          trailing: const Icon(Icons.access_time),
          onTap: () => _selectTime(context),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateDateTime();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _updateDateTime();
      });
    }
  }

  void _updateDateTime() {
    final DateTime combinedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    widget.onDateTimeSelected(combinedDateTime);
  }
}