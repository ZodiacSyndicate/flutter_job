import 'package:flutter/material.dart';
import 'package:flutter_job/api/api.dart';
import 'package:flutter_job/store/user.dart' show register, UserState;
import 'package:flutter_redux/flutter_redux.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

typedef void Callback({String username, String password, String type});

class RegisterState extends State<Register> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _type = 'genius';
  String _username = '';
  String _password = '';
  String _comfirmPassword = '';

  final request = Request();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<UserState, Callback>(
      converter: (store) {
        return ({
          String username,
          String password,
          String type,
        }) {
          store.dispatch(
              register(username: username, password: password, type: type));
        };
      },
      builder: (context, callback) {
        return Scaffold(
          appBar: AppBar(
            title: Text('注册'),
            centerTitle: true,
          ),
          body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: '用户名'),
                      onSaved: (val) {
                        setState(() {
                          _username = val;
                        });
                      },
                      validator: (val) {
                        return val.isEmpty ? '请输入用户名' : null;
                      },
                    ),
                    Divider(
                      height: 5.0,
                      color: Colors.transparent,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '密码'),
                      onSaved: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return '请输入密码';
                        }
                        return val.length < 6 ? '密码长度不能小于6位' : null;
                      },
                      obscureText: true,
                    ),
                    Divider(
                      height: 5.0,
                      color: Colors.transparent,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '确认密码'),
                      onSaved: (val) {
                        setState(() {
                          _comfirmPassword = val;
                        });
                      },
                      validator: (val) {
                        return val != _password ? '两次输入密码不同' : null;
                      },
                      obscureText: true,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.transparent,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 'boss',
                              groupValue: _type,
                              onChanged: _handleRadioChange,
                            ),
                            Text('Boss'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 'genius',
                              groupValue: _type,
                              onChanged: _handleRadioChange,
                            ),
                            Text('牛人')
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              onPressed: () async {
                                var form = _formKey.currentState;
                                form.save();
                                if (form.validate()) {
                                  callback(
                                    username: _username,
                                    password: _password,
                                    type: _type,
                                  );
                                }
                              },
                              child: Text(
                                '注册',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              color: Colors.lightBlue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  void _handleRadioChange(String val) {
    setState(() {
      _type = val;
    });
  }
}
