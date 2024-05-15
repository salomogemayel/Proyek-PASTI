import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditLokasiPage extends StatefulWidget {
  final Map<String, dynamic> data;

  EditLokasiPage({required this.data});

  @override
  _EditLokasiPageState createState() => _EditLokasiPageState();
}

class _EditLokasiPageState extends State<EditLokasiPage> {
  final TextEditingController ruanganController = TextEditingController();
  final TextEditingController lantaiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ruanganController.text = widget.data['ruangan'] ?? '';
    lantaiController.text = widget.data['lantai'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Lokasi'),
        backgroundColor: Color(0xFFDEF6F6),
      ),
      body: Container(
        color: Color(0xFFDEF6F6),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: ruanganController,
              decoration: InputDecoration(labelText: 'Ruangan'),
            ),
            TextFormField(
              controller: lantaiController,
              decoration: InputDecoration(labelText: 'Lantai'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _updateLokasi(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateLokasi(BuildContext context) async {
    final String ruangan = ruanganController.text;
    final String lantai = lantaiController.text;
    final String lokasiId = widget.data['ID'].toString();

    try {
      final response = await http.put(
        Uri.parse('http://192.168.18.54:9070/lokasi/$lokasiId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'ruangan': ruangan,
          'lantai': lantai,
        }),
      );

      if (response.statusCode == 200) {
        print('Lokasi updated successfully!');
        Navigator.of(context).pop(); // Close the edit screen
      } else {
        print('Failed to update lokasi: ${response.statusCode}, ${response.body}');
        // Show an error message if needed
      }
    } catch (error) {
      print('Error while updating lokasi: $error');
    }
  }
}
