import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart' show thunkMiddleware;
import 'package:redux_logging/redux_logging.dart';
import 'package:logging/logging.dart';

import './containers/chat.dart';
import './containers/info.dart';
import './containers/userlist.dart';
import './widgets/bottom_navigation.dart';
import './containers/register.dart';
import './store/main.dart' show AppState, appStateReducer;
import './store/user.dart' show UserState;
import './store/navigate.dart' show NavbarState;

void main() {
  final logger = Logger('Redux logger');
  final store = Store<AppState>(
    appStateReducer,
    middleware: [thunkMiddleware, LoggingMiddleware(logger: logger)],
    initialState: AppState(user: UserState(), navbar: NavbarState()),
  );

  runApp(FlutterJob(
    title: 'Flutter Job',
    store: store,
  ));
}

class FlutterJob extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  FlutterJob({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/register': (context) => Register(),
          '/': (context) => Home(),
        },
        theme: ThemeData.light(),
        title: title,
      ),
    );
  }
}

class Home extends StatelessWidget {
  final _widgetOptions = [UserList(), Chat(), Info()];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) {
        return store.state.navbar.index;
      },
      builder: (context, index) {
        return Scaffold(
          appBar: AppBar(
            title: Text('hehe'),
          ),
          body: _widgetOptions.elementAt(index),
          bottomNavigationBar: NavigationBar(),
          floatingActionButton: FlatButton(
            child: Text('注册'),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
          ),
        );
      },
    );
  }
}
