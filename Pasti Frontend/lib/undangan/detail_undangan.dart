import 'package:flutter/material.dart';

class DetailUndangan extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailUndangan({required this.data});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Detail Undangan'),
      backgroundColor: Color(0xFFDEF6F6),
    ),
    body: Container(
      color: Color(0xFFDEF6F6),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              'Host',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${data['host'] ?? ''}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ListTile(
            title: Text(
              'Pengunjung',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${data['pengunjung'] ?? ''}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ListTile(
            title: Text(
              'Subjek',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${data['subjek'] ?? ''}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ListTile(
            title: Text(
              'Deskripsi',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${data['deskripsi'] ?? ''}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ListTile(
            title: Text(
              'Lokasi',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${data['lokasi'] ?? ''}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ListTile(
            title: Text(
              'Waktu',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${data['waktu'] ?? ''}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    ),
  );
}

}
