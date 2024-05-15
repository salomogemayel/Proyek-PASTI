import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'edit_lokasi.dart';
import 'buat_lokasi.dart';

class LokasiGetData extends StatefulWidget {
  @override
  _LokasiGetDataState createState() => _LokasiGetDataState();
}

class _LokasiGetDataState extends State<LokasiGetData> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.18.54:9070/lokasi'));

      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(json.decode(response.body));
          print('Fetched data: $data');
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteData(String id) async {
    print('Deleting item with id: $id');
    try {
      final response = await http.delete(Uri.parse('http://192.168.18.54:9070/lokasi/$id'));

      print('Server response: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          data.removeWhere((element) => element['ID'].toString() == id);
        });
        print('Item with id: $id deleted successfully');
      } else {
        print('Failed to delete data: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  void refreshData() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi'),
        backgroundColor: Color(0xFFDEF6F6),
      ),
      body: Container(
        color: Color(0xFFDEF6F6),
        padding: EdgeInsets.all(8.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : data.isEmpty
                ? Center(
                    child: Text('No data available.'),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DataListItem(
                          data: data[index],
                          deleteCallback: () => deleteData(data[index]['ID'].toString()),
                          refreshData: refreshData,
                        );
                      },
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuatLokasiPage()),
          ).then((_) => refreshData());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DataListItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback deleteCallback;
  final VoidCallback refreshData;

  DataListItem({required this.data, required this.deleteCallback, required this.refreshData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(data['ruangan']),
        subtitle: Text("Lantai: ${data['lantai']}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditLokasiPage(data: data)),
                  ).then((_) => refreshData(),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                bool? confirmDelete = await _showDeleteConfirmationDialog(context);
                if (confirmDelete == true) {
                  print('Deleting item with id: ${data['ID']}');
                  deleteCallback();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
