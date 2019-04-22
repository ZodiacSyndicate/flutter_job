import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_job/store/navigate.dart' show ChangeIndex;
import 'package:flutter_job/store/main.dart' show AppState;

typedef void ChangeIndexAction(int index);

class NavigationBarProps {
  ChangeIndexAction changeIndex;
  String type;

  NavigationBarProps(
    this.changeIndex,
    this.type,
  );
}

class NavigationBar extends StatelessWidget {
  final int index;

  NavigationBar(this.index);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NavigationBarProps>(
      converter: (store) {
        return NavigationBarProps(
          (index) => store.dispatch(ChangeIndex(index)),
          store.state.user.type,
        );
      },
      builder: (context, props) => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(props.type == 'boss'
                    ? Icons.assignment
                    : Icons.location_city),
                title: Text(props.type == 'boss' ? '牛人' : 'Boss'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.comment),
                title: Text('聊天'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('我的'),
              ),
            ],
            onTap: (index) {
              props.changeIndex(index);
            },
            currentIndex: index,
          ),
    );
  }
}
