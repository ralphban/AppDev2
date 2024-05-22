import 'package:flutter/material.dart';
import 'db.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'edit_user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListUser(),
    );
  }
}

class ListUser extends StatefulWidget {
  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  final MyDb dbManager = MyDb();
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  Future<void> _refreshUserList() async {
    try {
      final data = await dbManager.getUsers();
      if (mounted) {
        setState(() {
          _users = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }


  Future<void> _addUser() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;

    await dbManager.insertUser({'first_name': firstName, 'last_name': lastName});

    _firstNameController.clear();
    _lastNameController.clear();
    _refreshUserList();
  }

  Widget _buildUserListItem(Map<String, dynamic> user) {
    return Card(
      child: ListTile(
        title: Text("${user['first_name']} ${user['last_name']}"),
        trailing: Wrap(
          spacing: 12,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditUserScreen(user: user),
                  ),
                );
                if (result == true) {
                  _refreshUserList();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await dbManager.deleteUser(user['id']);
                _refreshUserList();
              },
            ),
          ],
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 1'),
      ),
      drawer: _buildDrawer(context),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _firstNameController,
              decoration: InputDecoration(hintText: 'First name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _lastNameController,
              decoration: InputDecoration(hintText: 'Last name'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('ADD'),
                onPressed: _addUser,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) => _buildUserListItem(_users[index]),
            ),
          ),
        ],
      ),
    );
  }
}

