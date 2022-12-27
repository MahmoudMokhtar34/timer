import 'package:flutter/material.dart';
import './app_state.dart';
import './state_widget.dart';



class InheritedState extends InheritedWidget {
  const InheritedState(
      {required this.appState,
      required this.provider,
      super.key,
      required Widget child})
      : myChild = child,
        super(child: child);

  final Widget myChild;
  final AppState appState;
  final Provider provider;

  static Provider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedState>()
        ?.provider;
  }

  @override
  bool updateShouldNotify(InheritedState oldWidget) {
    return oldWidget.appState != appState;
    //return true;
  }
}
