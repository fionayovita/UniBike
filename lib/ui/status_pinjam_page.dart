import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/model/bike_model.dart';
import 'package:unibike/widgets/dropdown_menu.dart';

class StatusPinjamPage extends StatelessWidget {
  static const routeName = 'status_pinjam_page';
  final firebase = FirebaseAuth.instance;
  CollectionReference status =
      FirebaseFirestore.instance.collection('data_peminjaman');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 350,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  FutureBuilder<DocumentSnapshot>(
                    future: status.doc('1').get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        print(data['nama']);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID Sepeda',
                              style:
                                  TextStyle(fontSize: 15.0, color: greyOutline),
                            ),
                            Text(
                              '${data['id_sepeda']}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 22),
                            Text(
                              'Jenis Sepeda',
                              style:
                                  TextStyle(fontSize: 15.0, color: greyOutline),
                            ),
                            Text(
                              '${data['jenis_sepeda']}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 22),
                            Text(
                              'Email Peminjam',
                              style:
                                  TextStyle(fontSize: 15.0, color: greyOutline),
                            ),
                            Text(
                              data['email_peminjam'],
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 22),
                            Text(
                              'Waktu Peminjaman',
                              style:
                                  TextStyle(fontSize: 15.0, color: greyOutline),
                            ),
                            Text(
                              '01/12/2021 - 09.00 WIB',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 22),
                            Text(
                              'Waktu Pengembalian',
                              style:
                                  TextStyle(fontSize: 15.0, color: greyOutline),
                            ),
                            Text(
                              '01/12/2021 - 11.00 WIB',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 22),
                            Text(
                              'Fakultas Peminjaman',
                              style:
                                  TextStyle(fontSize: 15.0, color: greyOutline),
                            ),
                            Text(
                              'Fakultas ${data['fakultas']}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        );
                      }
                      return Text("loading");
                    },
                  ),
                  SizedBox(height: 22),
                  SizedBox(height: 50),
                  MaterialButton(
                    child: Text('Sudah Dikembalikan',
                        style: Theme.of(context).textTheme.headline5),
                    color: primaryColor,
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
