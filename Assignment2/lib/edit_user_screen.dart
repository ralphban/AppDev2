import 'package:flutter/material.dart';
import 'db.dart';

class EditUserScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  EditUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  final MyDb dbManager = MyDb();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user['first_name']);
    _lastNameController = TextEditingController(text: widget.user['last_name']);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill in all fields before updating."))
      );
      return;
    }

    try {
      await dbManager.updateUser({
        'id': widget.user['id'],
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User updated successfully')));
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUser,
              child: Text('Update User'),
            )
          ],
        ),
      ),
    );
  }
}
