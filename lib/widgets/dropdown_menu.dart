import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDownMenu> {
  String? fakultas;
  // _DropDownState({required this.fakultas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropdownButton<String>(
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: 'Teknik',
            child: Text('Teknik'),
          ),
          DropdownMenuItem<String>(
            value: 'MIPA',
            child: Text('MIPA'),
          ),
          DropdownMenuItem<String>(
            value: 'Kedokteran',
            child: Text('Kedokteran'),
          ),
          DropdownMenuItem<String>(
            value: 'Ekonomi',
            child: Text('Ekonomi'),
          ),
          DropdownMenuItem<String>(
            value: 'Pertanian',
            child: Text('Pertanian'),
          ),
          DropdownMenuItem<String>(
            value: 'Ilmu Sosial dan Pemerintahan',
            child: Text('Ilmu Sosial dan Pemerintahan'),
          ),
          DropdownMenuItem<String>(
            value: 'Keguruan dan Ilmu Pendidikan',
            child: Text('Keguruan dan Ilmu Pendidikan'),
          ),
        ],
        value: fakultas,
        hint: Text('Pilih Fakultas'),
        onChanged: (String? value) {
          setState(() {
            fakultas = value;
          });
        },
      ),
    );
  }
}
