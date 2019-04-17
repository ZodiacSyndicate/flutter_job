import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_job/widgets/bottom_navigation.dart';

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
        theme: ThemeData.dark(),
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
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
          persistentFooterButtons: <Widget>[
            StoreConnector<int, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(Actions.Increment);
              },
              builder: (context, callback) {
                return FlatButton(
                  onPressed: callback,
                  child: Icon(Icons.add),
                );
              },
            ),
            StoreConnector<int, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(Actions.Decrement);
              },
              builder: (context, callback) {
                return FlatButton(
                  onPressed: callback,
                  child: Icon(Icons.line_style),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
