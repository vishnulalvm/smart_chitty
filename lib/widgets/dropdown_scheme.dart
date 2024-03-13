import 'package:flutter/material.dart';

class DropdownTimePreriod extends StatefulWidget {
  const DropdownTimePreriod({super.key});

  @override
  State<DropdownTimePreriod> createState() => _DropdownTimePreriodState();
}

class _DropdownTimePreriodState extends State<DropdownTimePreriod> {
  String? selectedValue = 'Option 1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      
 enableFeedback: true,
                value: selectedValue,
                items: [
                  'Option 1',
                  'Option 2',
                  'Option 3',
                ].map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                hint: const Text('Select an option'),
              );
            
  }
}