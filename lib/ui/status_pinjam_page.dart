import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unibike/common/styles.dart';
import 'package:unibike/provider/alarm_provider.dart';
import 'package:unibike/provider/preferences_provider.dart';
import 'package:unibike/ui/home_page.dart';

class StatusPinjamPage extends StatefulWidget {
  static const routeName = 'status_pinjam_page';

  @override
  State<StatusPinjamPage> createState() => _StatusPinjamPageState();
}

class _StatusPinjamPageState extends State<StatusPinjamPage> {
  final firebase = FirebaseAuth.instance;

  final firestore = FirebaseFirestore.instance;
  bool statusPinjam = false;

  final CollectionReference status =
      FirebaseFirestore.instance.collection('data_peminjaman');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(child: _contentPinjam(context)),
        ),
      ),
    );
  }

  Widget _contentPinjam(BuildContext context) {
    statusPinjam = true;

    return Center(
      child: FutureBuilder<DocumentSnapshot>(
        future: status.doc(firebase.currentUser?.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Column(children: <Widget>[
              Image.asset(
                'assets/logoBulet.png',
                width: 250,
                height: 250,
              ),
              Text("Something went wrong",
                  style: Theme.of(context).textTheme.headline5)
            ]));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/logoBulet.png',
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(height: 15.0),
                  Text('Anda belum meminjam sepeda',
                      style: Theme.of(context).textTheme.headline5)
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print(data['nama']);
            return Container(
              width: 350,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status Peminjaman',
                    style: TextStyle(
                        fontSize: 28.0,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID Sepeda',
                        style: TextStyle(fontSize: 15.0, color: greyOutline),
                      ),
                      Text(
                        '${data['id_sepeda']}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Jenis Sepeda',
                        style: TextStyle(fontSize: 15.0, color: greyOutline),
                      ),
                      Text(
                        '${data['jenis_sepeda']}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Email Peminjam',
                        style: TextStyle(fontSize: 15.0, color: greyOutline),
                      ),
                      Text(
                        data['email_peminjam'],
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Waktu Peminjaman',
                        style: TextStyle(fontSize: 15.0, color: greyOutline),
                      ),
                      Text(
                        '${data['waktu_pinjam']}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Waktu Pengembalian',
                        style: TextStyle(fontSize: 15.0, color: greyOutline),
                      ),
                      Text(
                        '${data['waktu_kembali']}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Fakultas Peminjaman',
                        style: TextStyle(fontSize: 15.0, color: greyOutline),
                      ),
                      Text(
                        'Fakultas ${data['fakultas']}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Consumer<PreferencesProvider>(
                    builder: (context, provider, child) {
                      return Consumer<SchedulingProvider>(
                        builder: (context, scheduled, child) {
                          return MaterialButton(
                            child: Text('Sudah Dikembalikan',
                                style: Theme.of(context).textTheme.headline5),
                            color: primaryColor,
                            height: 53,
                            minWidth: MediaQuery.of(context).size.width,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              setState(() {
                                statusPinjam = false;
                              });
                              firestore
                                  .collection('data_peminjaman')
                                  .doc(firebase.currentUser?.uid)
                                  .delete()
                                  .then((value) =>
                                      print("Sepeda sudah dikembalikan"))
                                  .catchError((error) =>
                                      print("Failed to return bike: $error"));

                              scheduled.scheduledNews(false);
                              provider.enableAlarm(false);

                              
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Text("loading");
        },
      ),
    );
  }
}
