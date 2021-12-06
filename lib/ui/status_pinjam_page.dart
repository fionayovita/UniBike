import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';

class StatusPinjamPage extends StatelessWidget {
  static const routeName = 'status_pinjam_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
            width: 350,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(25.0),
              ),
              
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Status Peminjaman',
                      style: TextStyle(
                        fontSize: 28.0,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    'ID Sepeda',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: greyOutline),
                    ),
                  Text(
                    '123KTH',
                     style: Theme.of(context).textTheme.headline6,
                    ),
                  SizedBox(height: 22),
                  Text(
                    'Jenis Sepeda',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: greyOutline),
                    ),
                  Text(
                    'Sepeda Gunung',
                     style: Theme.of(context).textTheme.headline6,
                    ),  
                  SizedBox(height: 22),
                  Text(
                    'Nama',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: greyOutline),
                    ),
                  Text(
                    'Tiara Safitri',
                     style: Theme.of(context).textTheme.headline6,
                    ), 
                  SizedBox(height: 22),
                  Text(
                    'Waktu Peminjaman',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: greyOutline),
                      ),
                  Text(
                    '01/12/2021 - 09.00 WIB',
                     style: Theme.of(context).textTheme.headline6,
                    ),
                  SizedBox(height: 22),
                  Text(
                    'Waktu Pengembalian',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: greyOutline),
                      ),
                  Text(
                    '01/12/2021 - 11.00 WIB',
                     style: Theme.of(context).textTheme.headline6,
                    ),
                  SizedBox(height: 22),
                  Text(
                    'Fakultas Peminjaman',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: greyOutline),
                      ),
                  Text(
                    'Teknik',
                     style: Theme.of(context).textTheme.headline6,
                    ),
                  SizedBox(height: 50),
                  MaterialButton(
                      child: Text('Sudah Dikembalikan',
                          style: Theme.of(context).textTheme.headline5),
                      color: primaryColor,
                      // textTheme: ButtonTextTheme.primary,
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}