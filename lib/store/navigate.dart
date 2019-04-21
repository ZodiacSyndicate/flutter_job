class NavbarState {
  final int index;

  NavbarState({this.index = 0});
}

class ChangeIndex {
  final int index;

  ChangeIndex(this.index);
}

NavbarState navbarReducer(NavbarState state, action) {
  if (action is ChangeIndex) {
    return NavbarState(index: action.index);
  } else {
    return state;
  }
}
