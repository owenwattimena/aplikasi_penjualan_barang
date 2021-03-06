import 'package:aplikasi_penjualan_barang/model/history.dart';
import 'package:aplikasi_penjualan_barang/module/database.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import 'dart:async';

class ListActivity extends StatefulWidget {
  @override
  _ListActivityState createState() => _ListActivityState();
}

class _ListActivityState extends State<ListActivity> {
  List<History> listOfHistory;
  int count = 0;

  deleteList(int id) async {
    await DBProvider.db.deleteHistory(id);
    // print(id);
  }

  ListView getListView() {
    return ListView.builder(
      // separatorBuilder: (context, i) => Divider(
      //   color: Colors.black12,
      //   height: 5.0,
      // ),
      itemCount: count,
      itemBuilder: (BuildContext context, int i) {
        return Dismissible(
          background: stackBehindDismiss(),
          child: ListTile(
            title: Text(this.listOfHistory[i].namaBarang ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(this.listOfHistory[i].jumlahBeli.toString() +
                        'x' +
                        this.listOfHistory[i].harga.toString()),
                    Text((this.listOfHistory[i].harga *
                            this.listOfHistory[i].jumlahBeli)
                        .toString())
                  ],
                ),
                Text(this.listOfHistory[i].nama),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.black26,
                )
              ],
            ),
          ),
          key: Key(i.toString()),
          onDismissed: (direction) {
            deleteList(this.listOfHistory[i].id);
            this.listOfHistory.removeAt(i);
          },
        );
      },
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  listHistory() async {
    var historyList = await DBProvider.db.getAllHistories();
    setState(() {
      listOfHistory = historyList;
      count = historyList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listOfHistory == null) {
      listOfHistory = new List<History>();
      listHistory();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Penjualan'),
      ),
      body: Container(
        child: (this.listOfHistory.isNotEmpty)
            ? getListView()
            : Center(
                child: Text('Balum ada riwayat penjualan'),
              ),
      ),
    );
  }
}
