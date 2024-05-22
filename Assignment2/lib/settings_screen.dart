import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:assignment2/weather_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'main.dart';

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
            // Show the snackbar on tap
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

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings UI'),
        backgroundColor: Colors.orange,
      ),
      drawer: _buildDrawer(context),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Common', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text('English'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.cloud_queue),
            title: Text('Environment'),
            subtitle: Text('Production'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherScreen()),
              );
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone number'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            trailing: Icon(Icons.arrow_forward_ios),
            // Add the sign out functionality
            onTap: () {

            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Security', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Lock app in background'),
            trailing: CupertinoSwitch(
              value: true,
              onChanged: (bool value) {
              },
            ),
          ),
          // Add more settings options here
        ],
      ),
    );
  }
}
