import 'package:flutter/material.dart';

class DropdownButtonScheme extends StatefulWidget {
  final List<String> list;
  const DropdownButtonScheme({super.key, required this.list});

  @override
  State<DropdownButtonScheme> createState() => _DropdownButtonSchemeState();
}

class _DropdownButtonSchemeState extends State<DropdownButtonScheme> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
   
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: DropdownMenu<String>(
        enableSearch: true,
        width: 200,
        inputDecorationTheme: InputDecorationTheme(border: InputBorder.none,contentPadding: EdgeInsets.all(0)),
        hintText: 'Select Scheme',
        leadingIcon: const Padding(
          padding: EdgeInsets.all(8),
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
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),

              ));
        }).toList(),
      ),
    );
  }
}
