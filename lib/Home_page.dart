import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("API"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user['email'];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchuser,
      ),
    );
  }

  void fetchuser() async {
    print('fetchuser call');
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print('fetchuser comp..');
  }
}
