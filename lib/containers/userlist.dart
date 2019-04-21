import 'package:flutter/material.dart';
import '../widgets/boss_list.dart';
import '../widgets/genius_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/main.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) {
        return store.state.user.type;
      },
      builder: (context, type) {
        return type == 'boss' ? BossList() : GeniusList();
      },
    );
  }
}
