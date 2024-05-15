import 'package:flutter/material.dart';
import 'lokasi/lokasi.dart'; // Import the LokasiGetData widget
import 'undangan/undangan.dart'; // Import the UndanganGetData widget

void main() {
  runApp(MaterialApp(
    home: HomePage(), // Set HomePage as the home
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDEF6F6), // Set the background color to 0xFFDEF6F6
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100.0), // Added space above the icon
            Center(
              child: Icon(Icons.people, size: 120),
            ),
            SizedBox(height: 5.0),
            Text(
              'Visitor Management System',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to LokasiGetData() when the "Lokasi" button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LokasiGetData()),
                      );
                    },
                    child: Text('Lokasi'), // Button text
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the button background color to white
                      minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)), // Set the button size
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to UndanganGetData() when the "Undangan" button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UndanganGetData()),
                      );
                    },
                    child: Text('Undangan'), // Button text
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the button background color to DEF6F6
                      minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)), // Set the button size
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle navigation to other screens for "divisi"
                    },
                    child: Text('Divisi'), // Button text
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the button background color to white
                      minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)), // Set the button size
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}