import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:study_app/models/Habit.dart';
import 'package:study_app/providers/habit_provider.dart';

class AddHabitDialog extends StatefulWidget {
  final Function(Habit) onSave;

  const AddHabitDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddHabitDialogState createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _dueDate;
  TimeOfDay? _dueTime;
  bool _isCompleted = false;
  int _frequencyType = 0; // Default: Once
  int _targetCount = 1;
  int? _startDate;
  String _color =
      '#${Random().nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  final List<String> _frequencyOptions = [
    'Once',
    'Daily',
    'Weekly',
    'Monthly',
    'Custom',
  ];
  final List<String> _colorOptions = [
    '#FFECB3', // Amber light
    '#FFCCBC', // Deep Orange light
    '#C8E6C9', // Green light
    '#BBDEFB', // Blue light
    '#D1C4E9', // Deep Purple light
    '#F8BBD0', // Pink light
    '#B2DFDB', // Teal light
    '#E1BEE7', // Purple light
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
        final currentDate = Provider.of<HabitProvider>(context, listen: false).currentDate!;
        _startDate = DateTime(currentDate.year, currentDate.month, currentDate.day).millisecondsSinceEpoch;
   
      });
    }
  }

  void _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _dueTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _dueTime = pickedTime;
      });
    }
  }

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      final newHabit = Habit(
        title: _titleController.text,
        description: _descriptionController.text,
        due_date: _frequencyType == 0 ? null : _dueDate,
        due_time:
            _frequencyType != 0 && _dueDate != null && _dueTime != null
                ? DateTime(
                  _dueDate!.year,
                  _dueDate!.month,
                  _dueDate!.day,
                  _dueTime!.hour,
                  _dueTime!.minute,
                )
                : null,
        isCompleted: _isCompleted,
        frequency_type: _frequencyType,
        target_count: _frequencyType == 0 ? 1 : _targetCount,
        start_date: _startDate,
        color: _color,
      );

      widget.onSave(newHabit);
      Navigator.of(context).pop();
    }
  }

  // Helper method to convert hex string to Color
  Color _hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add New Habit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Frequency',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  value: _frequencyType,
                  items: List.generate(
                    _frequencyOptions.length,
                    (index) => DropdownMenuItem(
                      value: index,
                      child: Text(_frequencyOptions[index]),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _frequencyType = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Only show date/time pickers if frequency is not "Once"
                if (_frequencyType != 0) ...[
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _pickDate,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Due Date',
                              border: OutlineInputBorder(),
                            ),
                            child: Text(
                              _dueDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_dueDate!)
                                  : 'Select Date',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: _pickTime,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Due Time',
                              border: OutlineInputBorder(),
                            ),
                            child: Text(
                              _dueTime != null
                                  ? _dueTime!.format(context)
                                  : 'Select Time',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Target Count:'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Slider(
                          value: _targetCount.toDouble(),
                          min: 1,
                          max: 30,
                          divisions: 29,
                          label: _targetCount.toString(),
                          onChanged: (value) {
                            setState(() {
                              _targetCount = value.toInt();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 30,
                        alignment: Alignment.center,
                        child: Text('$_targetCount'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                const Text(
                  'Color',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _colorOptions.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final color = _colorOptions[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _color = color;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _hexToColor(color),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  _color == color
                                      ? Colors.black
                                      : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Already Completed?'),
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveHabit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Save Habit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}