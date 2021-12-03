import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';

class DropDownMenu extends StatefulWidget {
  @override
  State<DropDownMenu> createState() => DropDownMenuState();
}

class DropDownMenuState extends State<DropDownMenu> {
  String? fakultas;
  int lengthBike = 30;

  List _listFakultas = [
    "Teknik",
    "MIPA",
    "Ekonomi",
    "Kedokteran",
    "Pertanian",
    "Keguruan dan Ilmu Pendidikan",
    "Ilmu Sosial dan Pemerintahan",
    "Hukum"
  ];

  int lengthFakultas() {
    int length = lengthBike;
    if (fakultas == 'Teknik') {
      length = 2;
    } else if (fakultas == 'MIPA') {
      length = 6;
    } else if (fakultas == 'Ekonomi') {
      length = 1;
    } else if (fakultas == 'Kedokteran') {
      lengthBike = 7;
    } else if (fakultas == 'Pertanian') {
      lengthBike = 7;
    } else if (fakultas == 'Keguruan dan Ilmu Pendidikan') {
      length = 12;
    } else if (fakultas == 'Ilmu Sosial dan Pemerintahan') {
      length = 4;
    } else if (fakultas == 'Hukum') {
      length = 9;
    } else {
      print(fakultas);
      length;
    }
    lengthBike = length;
    return length;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      iconEnabledColor: primaryColor,
      dropdownColor: secondaryColor,
      hint:
          Text("Pilih Fakultas", style: Theme.of(context).textTheme.subtitle2),
      value: fakultas,
      items: _listFakultas.map((value) {
        return DropdownMenuItem(
          child: Text(value, style: Theme.of(context).textTheme.subtitle2),
          value: value,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          fakultas = value as String?;
          lengthFakultas();
          lengthBike = lengthFakultas();
        });
      },
    );
  }
}
