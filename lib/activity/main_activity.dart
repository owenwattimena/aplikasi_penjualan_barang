import 'package:aplikasi_penjualan_barang/activity/list_activity.dart';
import 'package:aplikasi_penjualan_barang/model/history.dart';
import 'package:aplikasi_penjualan_barang/module/database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:async';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  final _formKey = GlobalKey<FormState>();
  int totalBelanja;
  int kembali;
  TextEditingController _nama = new TextEditingController();
  TextEditingController _barang = new TextEditingController();
  TextEditingController _jumlah = new TextEditingController();
  TextEditingController _harga = new TextEditingController();
  TextEditingController _bayar = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      this.totalBelanja = 0;
      this.kembali = 0;
    });
  }

  proses() {
    setState(() {
      this.totalBelanja = int.parse(_jumlah.text) * int.parse(_harga.text);
      this.kembali = int.parse(_bayar.text) - this.totalBelanja;
    });
  }

  reset() {
    _nama.text = '';
    _barang.text = '';
    _jumlah.text = '';
    _harga.text = '';
    _bayar.text = '';
    setState(() {
      this.totalBelanja = 0;
      this.kembali = 0;
    });
  }

  transaksiBaru() async {
    if (totalBelanja == 0) {
      Toast.show("Tekan Tombol Proses Terlebih dahulu", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (kembali < 0) {
      Toast.show("Uang Kurang!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    await DBProvider.db.newHistory(
      new History(
        nama: _nama.text,
        namaBarang: _barang.text,
        jumlahBeli: int.parse(_jumlah.text),
        harga: int.parse(_harga.text),
        bayar: int.parse(_bayar.text),
      ),
    );
    Toast.show("Transaksi Berhasil", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    reset();
  }

  infoApp() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info Aplikasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Mata Kuliah QMS.'),
                Text('\"Mari Bajual!\"'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text('Karya Anak TI C 2016 POLNAM'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Charla Gracia Dezire Sopacua',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '1316144070',
                  style: TextStyle(fontSize: 14),
                ),
                Text('Owen Wattimena',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '1316144074',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Text('Ter Eeunch'),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mari Bajual!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListActivity()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              infoApp();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nama,
                decoration: InputDecoration(
                  labelText: 'Nama Pembeli',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan Nama Pembeli';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextFormField(
                controller: _barang,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan Nama Barang';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _jumlah,
                decoration: InputDecoration(
                  labelText: 'Jumlah Beli',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan Jumlah Beli';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _harga,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan Harga';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _bayar,
                decoration: InputDecoration(
                  labelText: 'Bayar',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan Bayar';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'PROSES',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    proses();
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text('Total Belanja : '),
              Text(
                '$totalBelanja',
                style: TextStyle(fontSize: 35),
              ),
              Text('Kembali : '),
              Text('$kembali', style: TextStyle(fontSize: 35)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: RaisedButton(
                          child: Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            reset();
                          },
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Transaksi Baru',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            transaksiBaru();
                          }
                        },
                        color: Colors.green,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
