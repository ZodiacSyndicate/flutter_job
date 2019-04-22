import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_job/store/main.dart' show AppState;
import 'package:flutter_job/widgets/boss_info.dart';
import 'package:flutter_job/widgets/genius_info.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) {
        return store.state.user.type;
      },
      builder: (context, type) {
        return type == 'boss' ? BossInfo() : GeniusInfo();
      },
    );
  }
}
