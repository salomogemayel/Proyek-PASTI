import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditUndangan extends StatefulWidget {
  final Map<String, dynamic> data;

  EditUndangan({required this.data});

  @override
  _EditUndanganState createState() => _EditUndanganState();
}

class _EditUndanganState extends State<EditUndangan> {
  final TextEditingController hostController = TextEditingController();
  final TextEditingController subjekController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController waktuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hostController.text = widget.data['host'] ?? '';
    subjekController.text = widget.data['subjek'] ?? '';
    deskripsiController.text = widget.data['deskripsi'] ?? '';
    lokasiController.text = widget.data['lokasi'] ?? '';
    waktuController.text = widget.data['waktu'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Undangan'),
        backgroundColor: Color(0xFFDEF6F6),
      ),
      body: Container(
        color: Color(0xFFDEF6F6),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: hostController,
              decoration: InputDecoration(labelText: 'Host'),
            ),
            TextFormField(
              controller: subjekController,
              decoration: InputDecoration(labelText: 'Subjek'),
            ),
            TextFormField(
              controller: deskripsiController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextFormField(
              controller: lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi'),
            ),
            TextFormField(
              controller: waktuController,
              decoration: InputDecoration(labelText: 'Waktu'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _updateUndangan(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUndangan(BuildContext context) async {
    final String host = hostController.text;
    final String subjek = subjekController.text;
    final String deskripsi = deskripsiController.text;
    final String lokasi = lokasiController.text;
    final String waktu = waktuController.text;
    final String undanganId = widget.data['ID'].toString();

    try {
      final response = await http.put(
        Uri.parse('http://192.168.18.54:9060/undangan/$undanganId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'host': host,
          'Subjek': subjek,
          'deskripsi': deskripsi,
          'lokasi': lokasi,
          'waktu': waktu,
        }),
      );

      if (response.statusCode == 200) {
        print('Undangan updated successfully!');
        Navigator.of(context).pop(); // Close the edit screen
      } else {
        print('Failed to update undangan: ${response.statusCode}, ${response.body}');
        // Show an error message if needed
      }
    } catch (error) {
      print('Error while updating undangan: $error');
    }
  }
}
