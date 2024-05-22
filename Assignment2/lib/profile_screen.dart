import 'package:assignment2/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'photo.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'main.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    List<dynamic> parsedJson = jsonDecode(response.body);
    return parsedJson.map((json) => Photo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load photos');
  }
}

Drawer _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.orange,
          ),
          child: Text(
            'Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Task 1'),
          onTap: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ListUser()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NotificationsScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Sign out'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You are logging out from the app'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ],
    ),
  );
}


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RetrofitExercise'),
        backgroundColor: Colors.purple,
      ),
      drawer: _buildDrawer(context),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No photos found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final photo = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(photo.thumbnailUrl),
                      radius: 24.0,
                    ),
                    title: Text(
                      photo.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        'Album ID: ${photo.albumId} - Photo ID: ${photo.id}'),
                    trailing: Image.network(
                      photo.url,
                      width: 100,
                      height: 100,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
