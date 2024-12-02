import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Contact Us', style: Theme.of(context).textTheme.headlineSmall),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
                style: TextStyle(color: Colors.black), // Set text color to black
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black), // Set text color to black
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                onSaved: (value) => email = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.message),
                  hintText: 'Enter your message',
                  labelText: 'Message',
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 5,
                style: TextStyle(color: Colors.black), // Set text color to black
                validator: (value) => value!.isEmpty ? 'Please enter your message' : null,
                onSaved: (value) => message = value,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle submission
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
