import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: DivisiPage(), // Set DivisiPage as the home
  ));
}

class DivisiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Divisi'),
        backgroundColor: Color(0xFFDEF6F6),
      ),
      body: Container(
        color: Color(0xFFDEF6F6),
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: DivisiDummyData.generateDummyData().length,
          itemBuilder: (BuildContext context, int index) {
            final divisi = DivisiDummyData.generateDummyData()[index];
            return Card(
              color: Colors.white,
              child: ListTile(
                title: Text(divisi['nama']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDivisiPage(data: divisi),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () {
                        // Add logic to delete the Divisi here
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuatDivisiForm()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class EditDivisiPage extends StatefulWidget {
  final Map<String, dynamic> data;

  EditDivisiPage({required this.data});

  @override
  _EditDivisiPageState createState() => _EditDivisiPageState();
}

class _EditDivisiPageState extends State<EditDivisiPage> {
  final TextEditingController namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    namaController.text = widget.data['nama'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Divisi'),
        backgroundColor: Color(0xFFDEF6F6),
      ),
      body: Container(
        color: Color(0xFFDEF6F6),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama Divisi'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _updateDivisi(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateDivisi(BuildContext context) async {
    final String nama = namaController.text;
    final String divisiId = widget.data['ID'].toString();

    try {
      final response = await http.put(
        Uri.parse('http://192.168.18.54:9070/divisi/$divisiId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama': nama,
        }),
      );

      if (response.statusCode == 200) {
        print('Divisi updated successfully!');
        Navigator.of(context).pop(); // Close the edit screen
      } else {
        print('Failed to update divisi: ${response.statusCode}, ${response.body}');
        // Show an error message if needed
      }
    } catch (error) {
      print('Error while updating divisi: $error');
    }
  }
}

class DivisiDummyData {
  static List<Map<String, dynamic>> generateDummyData() {
    return [
      {'ID': 1, 'nama': 'Keuangan'},
      {'ID': 2, 'nama': 'Pemasaran'},
      {'ID': 3, 'nama': 'Sumber Daya Manusia'},
      {'ID': 4, 'nama': 'Operasional'},
      {'ID': 5, 'nama': 'Penelitian dan Pengembangan'},
    ];
  }
}

class BuatDivisiForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Divisi'),
        backgroundColor: Color(0xFFDEF6F6),
      ),
      body: Container(
        color: Color(0xFFDEF6F6),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nama Divisi'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to save the Divisi here
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
