import 'package:flutter/material.dart';
import 'package:study_app/utils/Color_helper.dart';

class ColorPickerDialog extends StatefulWidget {
  final String initialColor;
  final Function(String) onColorSelected;

  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    required this.onColorSelected,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late String _selectedColor;
  final Color_helper colorHelper = Color_helper();
  
  // Sample color options
  final List<String> _colorOptions = [
    "#FFFFFF", // White
    "#F8BBD0", // Pink
    "#FFCDD2", // Light Red
    "#FFE0B2", // Light Orange
    "#FFF9C4", // Light Yellow
    "#C8E6C9", // Light Green
    "#B2DFDB", // Light Teal
    "#B3E5FC", // Light Blue
    "#D1C4E9", // Light Purple
  ];

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  // Helper function to determine text color based on background color
  Color _getTextColor(Color backgroundColor) {
    // Calculate brightness to decide if text should be dark or light
    if ((backgroundColor.red + backgroundColor.green + backgroundColor.blue) > 500) {
      return Colors.black87;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Color', style: Theme.of(context).textTheme.titleMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _colorOptions.map((color) {
              final colorValue = colorHelper.HexToColor(color);
              final isSelected = _selectedColor == color;
    
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colorValue,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 20,
                          color: _getTextColor(colorValue),
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          
          // Preview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorHelper.HexToColor(_selectedColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Color Preview',
                style: TextStyle(
                  color: _getTextColor(colorHelper.HexToColor(_selectedColor)),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onColorSelected(_selectedColor);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text('Select'),
        ),
      ],
    );
  }
}



                