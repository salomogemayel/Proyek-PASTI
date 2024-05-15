import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuatUndangan extends StatelessWidget {
  final TextEditingController hostController = TextEditingController();
  final TextEditingController pengunjungController = TextEditingController();
  final TextEditingController subjekController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController waktuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Undangan'),
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
              controller: pengunjungController,
              decoration: InputDecoration(labelText: 'Pengunjung'),
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
                _saveUndangan(context);
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(),
            ),
          ],
        ),
      ),
    );
  }

  void _saveUndangan(BuildContext context) async {
    final String host = hostController.text;
    final String pengunjung = pengunjungController.text;
    final String subjek = subjekController.text;
    final String deskripsi = deskripsiController.text;
    final String lokasi = lokasiController.text;
    final String waktu = waktuController.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.18.54:9060/undangan'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'host': host,
          'pengunjung': pengunjung,
          'subjek': subjek,
          'deskripsi': deskripsi,
          'lokasi': lokasi,
          'waktu': waktu,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('New undangan saved!');
        _showConfirmationDialog(context);
        _clearTextFields();
      } else {
        print('Failed to save undangan: ${response.body}');
        _showErrorDialog(context);
      }
    } catch (error) {
      print('Error while saving undangan: $error');
      _showErrorDialog(context);
    }
  }

  void _clearTextFields() {
    hostController.clear();
    pengunjungController.clear();
    subjekController.clear();
    deskripsiController.clear();
    lokasiController.clear();
    waktuController.clear();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Undangan has been saved successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(true); // Go back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to save undangan. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
