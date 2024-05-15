import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'buat_undangan.dart'; 
import 'detail_undangan.dart'; 
import 'edit_undangan.dart';

class UndanganGetData extends StatefulWidget {
  @override
  _UndanganGetDataState createState() => _UndanganGetDataState();
}

class _UndanganGetDataState extends State<UndanganGetData> {
  List<Map<String, dynamic>> undanganData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.18.54:9060/undangan'));

    if (response.statusCode == 200) {
      setState(() {
        try {
          undanganData = List<Map<String, dynamic>>.from(json.decode(response.body));
          print('Fetched data: $undanganData'); 
        } catch (e) {
          print('Error decoding JSON: $e');
          undanganData = [];
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to load data: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteData(String id) async {
    print('Deleting item with id: $id');
    try {
      final response = await http.delete(Uri.parse('http://192.168.18.54:9060/undangan/$id'));

      print('Server response: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          undanganData.removeWhere((element) => element['ID'].toString() == id);
        });
        print('Item with id: $id deleted successfully');
        refreshData(); // Refresh the list after deleting
      } else {
        print('Failed to delete data: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to delete data');
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
      title: Text('Undangan'),
      backgroundColor: Color(0xFFDEF6F6),
    ),
    body: Container(
      color: Color(0xFFDEF6F6),
      padding: EdgeInsets.all(8.0),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : undanganData.isEmpty
              ? Center(
                  child: Text('No data available.'),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    itemCount: undanganData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DataListItem(
                        data: undanganData[index],
                        deleteCallback: () => deleteData(undanganData[index]['ID'].toString()),
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
          MaterialPageRoute(builder: (context) => BuatUndangan()),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailUndangan(data: data)),
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          title: Text("${data['subjek'] ?? ''}"),
          subtitle: Text("Host: ${data['host'] ?? ''}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditUndangan(data: data)),
                  ).then((_) => refreshData());
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  bool? confirmDelete = await _showDeleteConfirmationDialog(context);
                  if (confirmDelete == true) {
                    print('Deleting item with id: ${data['undangan_id']}');
                    deleteCallback();
                  }
                },
              ),
            ],
          ),
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
