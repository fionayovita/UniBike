import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/widgets/list_sepeda.dart';

typedef OnChangeCallback = void Function(dynamic value);

class DropDownMenu extends StatefulWidget {
  String fakultasMain = '';
  final OnChangeCallback onChanged;

  DropDownMenu({required this.onChanged});

  @override
  State<DropDownMenu> createState() => DropDownMenuState();
}

class DropDownMenuState extends State<DropDownMenu> {
  String? fakultas;
  int lengthBike = 0;

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
      length = 11;
    } else if (fakultas == 'Ilmu Sosial dan Pemerintahan') {
      length = 4;
    } else if (fakultas == 'Hukum') {
      length = 9;
    } else {
      length;
    }
    print('di length fakultas: $fakultas');
    lengthBike = length;
    return length;
  }

  String getDropDownItem() {
    setState(() {
      widget.fakultasMain = fakultas!;
    });
    print('getdropdown fakultas: $fakultas');
    print('getdropdown fakultasMain: ${widget.fakultasMain}');
    return widget.fakultasMain;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          //alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
            child: DropdownButton(
            iconEnabledColor: primaryColor,
            dropdownColor: secondaryColor,
            hint: Text("Pilih Fakultas",
                style: Theme.of(context).textTheme.subtitle2),
            value: fakultas,
            items: _listFakultas.map(
              (value) {
                return DropdownMenuItem<String>(
                  child:
                      Text(value, style: Theme.of(context).textTheme.subtitle2),
                  value: value,
                );
              },
            ).toList(),
            onChanged: (value) {
              setState(
                () {
                  fakultas = value as String;
                  widget.fakultasMain = value;
                  widget.onChanged(value);
                  getDropDownItem();
                  print('widget ${widget.fakultasMain}');
                  lengthBike = lengthFakultas();
                  ListSepeda(length: lengthBike);
                },
              );
            },
          ),
          ),
          ),
          
        ),
        SizedBox(height: 18.0),
        Text(
            fakultas == null
                ? 'Pilih fakultas untuk melihat jumlah sepeda'
                : 'Sepeda yang tersedia di fakultas $fakultas: $lengthBike',
            style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center,), 
        SizedBox(height: 15.0),
        ListSepeda(length: lengthBike)
      ],
    );
  }
}
