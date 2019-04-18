import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String type = 'genius';
  String username = '';
  String password = '';
  String comfirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: '用户名'),
                  onSaved: (val) {
                    setState(() {
                      username = val;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '密码'),
                  onSaved: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  obscureText: true,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '确认密码'),
                  onSaved: (val) {
                    setState(() {
                      comfirmPassword = val;
                    });
                  },
                  obscureText: true,
                )
              ],
            ),
          )),
    );
  }
}
