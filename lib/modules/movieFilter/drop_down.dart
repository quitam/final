import 'package:final_project/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

typedef FilterDropDownCallBack = void Function(String);

class FilterDropDown extends StatefulWidget {
  final FilterDropDownCallBack callback;
  const FilterDropDown({super.key, required this.callback});
  @override
  _FilterDropDownState createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  String dropdownValue = 'Thời gian chiếu'; // Set the initial selected value

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? newValue) {
            setState(() {
              widget.callback(newValue ?? 'Thời gian chiếu');
              dropdownValue = newValue!;
            });
          },
          underline: Container(), // Remove the default underline
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          items: <String>[
            'Thời gian chiếu',
            'Tên',
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(value),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}