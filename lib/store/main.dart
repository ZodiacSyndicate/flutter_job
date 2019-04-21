import './user.dart';
import './navigate.dart';

class AppState {
  final NavbarState navbar;
  final UserState user;

  AppState({this.navbar, this.user});
}

AppState appStateReducer(AppState state, action) => AppState(
      navbar: navbarReducer(state.navbar, action),
      user: userReducer(state.user, action),
    );
