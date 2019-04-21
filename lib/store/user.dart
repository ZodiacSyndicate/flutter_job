import 'package:redux_thunk/redux_thunk.dart' show ThunkAction;
import 'package:redux/redux.dart' show Store;
import 'package:flutter_job/api/api.dart' show Request;
import 'navigate.dart';
import '../utils/utils.dart';

enum UserActionTypes {
  REGISTER,
  AUTH_SUCCESS,
}

class UserState {
  final String msg;
  final String username;
  final String type;
  final bool logined;

  UserState({
    this.msg = '',
    this.username = '',
    this.type = '',
    this.logined = false,
  });
}

class RegisterParams {
  final String username;
  final String password;
  final String type;

  RegisterParams(this.username, this.password, this.type);
}

class Register {
  final UserActionTypes type;
  final RegisterParams payload;

  Register({this.type = UserActionTypes.REGISTER, this.payload});
}

class AuthSuccess {
  final UserActionTypes type;
  final Map payload;

  AuthSuccess({this.type = UserActionTypes.AUTH_SUCCESS, this.payload});
}

UserState userReducer(UserState state, action) {
  switch (action.type) {
    case UserActionTypes.REGISTER:
      return state;
    case UserActionTypes.AUTH_SUCCESS:
      return UserState(
        logined: true,
        username: action.payload['username'],
        type: action.payload['type'],
      );
    default:
      return state;
  }
}

ThunkAction<UserState> register(
    {String username, String password, String type}) {
  return (Store<UserState> store) async {
    final request = Request();
    final response = await request.register(
      username: username,
      password: password,
      type: type,
    );
    if (response.data['code'] == 0) {
      store.dispatch(AuthSuccess(payload: response.data['data']));
      store.dispatch(ChangeIndex(getIndex(
        type: response.data['data']['type'],
        avatar: response.data['data']['avatar'],
      )));
    }
  };
}
