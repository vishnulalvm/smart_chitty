import 'package:flutter/material.dart';

typedef TimePeriodCallback = void Function(String selectedValue);

class DropdownTimePreriod extends StatefulWidget {
  
  final TimePeriodCallback onTimePeriodChanged;
  const DropdownTimePreriod({super.key, required this.onTimePeriodChanged});

  @override
  State<DropdownTimePreriod> createState() => _DropdownTimePreriodState();
}

class _DropdownTimePreriodState extends State<DropdownTimePreriod> {
  String? selectedValue = 'Months';
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        width: 180,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: DropdownButton<String>(
          
          iconSize: 26,
          underline: const SizedBox(),
          enableFeedback: true,
          value: selectedValue,
          items: [
            'Days',
            'Weeks',
            'Months',
          ]
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
             widget.onTimePeriodChanged(newValue!);
          },
          hint: const Text('Select an option'),
        ),
      ),
    );
  }
}
