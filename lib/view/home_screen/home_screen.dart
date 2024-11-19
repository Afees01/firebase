import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controller/home_screen%20_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Student {
  String name;
  String subject;
  String phone;

  Student({required this.name, required this.subject, required this.phone});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<HomeScreen> {
  final List<Student> _students = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int? _editingIndex;
  final Stream<QuerySnapshot> _studentstream =
      FirebaseFirestore.instance.collection('students').snapshots();

  void _addOrEditStudent() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        name: _nameController.text,
        subject: _subjectController.text,
        phone: _phoneController.text,
      );
      HomeScreenController.addData(
          name: _nameController.text,
          ph: _phoneController.text,
          sub: _subjectController.text);

      setState(() {
        if (_editingIndex == null) {
          _students.add(student);
        } else {
          _students[_editingIndex!] = student;
          _editingIndex = null;
        }
      });

      _clearForm();
      Navigator.of(context).pop();
    }
  }

  void _clearForm() {
    _nameController.clear();
    _subjectController.clear();
    _phoneController.clear();
  }

  void _editStudent(int index) {
    setState(() {
      _editingIndex = index;
      final student = _students[index];
      _nameController.text = student.name;
      _subjectController.text = student.subject;
      _phoneController.text = student.phone;
    });
    _showFormDialog();
  }

  void _showFormDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_editingIndex == null ? 'Add Student' : 'Edit Student'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) => value!.isEmpty ? 'Enter subject' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Enter phone number' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearForm();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addOrEditStudent,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: _studentstream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: const Text("something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final studentList = snapshot.data!.docs;
                return ListTile(
                  title: Text(studentList[index]["name"]),
                  subtitle: Text(
                      '${studentList[index]["sub"]} - ${studentList[index]["ph"]}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editStudent(index),
                      ),
                      IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => HomeScreenController.deleteDAta(
                              studentList[index].id)),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
