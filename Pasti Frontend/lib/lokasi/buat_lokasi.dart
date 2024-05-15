import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuatLokasiPage extends StatelessWidget {
  final TextEditingController lantaiController = TextEditingController();
  final TextEditingController ruanganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Lokasi'),
        backgroundColor: Color(0xFFDEF6F6),
      ),
      body: Container(
        color: Color(0xFFDEF6F6),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: lantaiController,
              decoration: InputDecoration(labelText: 'Lantai'),
            ),
            TextFormField(
              controller: ruanganController,
              decoration: InputDecoration(labelText: 'Ruangan'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveLokasi(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveLokasi(BuildContext context) async {
    final String lantai = lantaiController.text;
    final String ruangan = ruanganController.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.18.54:9070/lokasi'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'lantai': lantai,
          'ruangan': ruangan,
        }),
      );

      if (response.statusCode == 200) {
        print('New lokasi saved!');
        _showConfirmationDialog(context);
      } else {
        print('Failed to save lokasi: ${response.body}');
      }
    } catch (error) {
      print('Error while saving lokasi: $error');
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Lokasi has been saved successfully!'),
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
}
