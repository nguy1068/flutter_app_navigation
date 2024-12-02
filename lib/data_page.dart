import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<List<User>> userList;

  @override
  void initState() {
    super.initState();
    userList = fetchUsers(); // Initialize the userList
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://api.github.com/users'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitHub Users')),
      body: FutureBuilder<List<User>>(
        future: userList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.login),
                  subtitle: Text(user.htmlUrl),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class User {
  final String login;
  final String htmlUrl;

  User({required this.login, required this.htmlUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      htmlUrl: json['html_url'],
    );
  }
}
