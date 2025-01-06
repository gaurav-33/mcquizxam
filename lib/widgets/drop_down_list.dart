import 'package:flutter/material.dart';
import '../res/theme.dart';

class DropDownList<T> extends StatelessWidget {
  final List<T> items;
  final String hint;
  final ValueChanged<T?> onChanged;
  final T? value;
  final String? selectedItemId;

  const DropDownList({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.value,
    this.selectedItemId,
  });

  @override
  Widget build(BuildContext context) {
    // Find the current value based on selectedItemId, or use null if not found
    T? currentValue;
    if (selectedItemId != null) {
      try {
        currentValue = items.firstWhere(
          (item) => item.toString() == selectedItemId,
        );
      } catch (e) {
        currentValue = null; // No matching item found
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        decoration: BoxDecoration(
          color: AppTheme.neptune400,
          border: Border.all(color: AppTheme.neptune500, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButton<T>(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          borderRadius: BorderRadius.circular(40),
          dropdownColor: AppTheme.neptune300,
          isExpanded: true,
          underline: const SizedBox(),
          hint: Text(
            hint,
            style: const TextStyle(color: AppTheme.neptune800),
          ),
          value: value ?? currentValue,
          // Use provided value or the found value
          items: items.map<DropdownMenuItem<T>>((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                value.toString(),
                style: const TextStyle(color: AppTheme.neptune900),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
