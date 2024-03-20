import 'package:flutter/material.dart';

String? dropdownValue;
class DropdownButtonScheme extends StatefulWidget {
  final List<String> list;
  const DropdownButtonScheme({super.key, required this.list});

  @override
  State<DropdownButtonScheme> createState() => _DropdownButtonSchemeState();
}

class _DropdownButtonSchemeState extends State<DropdownButtonScheme> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30)),
      child: DropdownMenu<String>(
        expandedInsets: EdgeInsets.zero,
        enableSearch: true,
        // width: 180,
        inputDecorationTheme: const InputDecorationTheme(
         
          
          border: InputBorder.none,

        ),
        hintText: 'Select Schemem',
        leadingIcon: const Padding(
          padding: EdgeInsets.all(6),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
          ),
        ),
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            widget.list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
            value: value,
            label: value,
            
          );
        }).toList(),
      ),
    );
  }
}
