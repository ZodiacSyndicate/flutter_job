import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_job/widgets/bottom_navigation.dart';
import 'package:flutter_job/containers/register.dart';

enum Actions { Increment, Decrement }

int countReducer(int state, dynamic action) {
  switch (action) {
    case Actions.Increment:
      return state + 1;
    case Actions.Decrement:
      return state - 1;
    default:
      return state;
  }
}

void main() {
  final store = Store<int>(countReducer, initialState: 0);

  runApp(FlutterReudxApp(
    title: 'Flutter Redux App',
    store: store,
  ));
}

class FlutterReudxApp extends StatelessWidget {
  final Store<int> store;
  final String title;

  FlutterReudxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/register': (context) => Register(),
          '/': (context) => Home()
        },
        theme: ThemeData.light(),
        title: title,
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hehe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You hav pushed the button this many times'),
            StoreConnector<int, String>(
              converter: (store) => store.state.toString(),
              builder: (context, count) {
                return Text(
                  count,
                  style: Theme.of(context).textTheme.display1,
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(),
      floatingActionButton: FlatButton(
        child: Text('注册'),
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
      ),
    );
  }
}
