import 'package:flutter/material.dart';

import './app_state.dart';
import './inherited_state.dart';

class StateWidget extends StatefulWidget {
  const StateWidget({super.key, required this.child});

  final Widget child;

  @override
  State<StateWidget> createState() => Provider();
}

class Provider extends State<StateWidget> {
  AppState appState = AppState();

  @override
  Widget build(BuildContext context) {
    return InheritedState(
        appState: appState, provider: this, child: widget.child);
  }

  void increment(int by) {
    final int newCount = appState.counter + by;
    final newAppState = appState.copyWith(counter: newCount);

    setState(() {
      appState = newAppState;
    });
  }

   void setCounter(int to) {
    
    final newAppState = appState.copyWith(counter: to);

    setState(() {
      appState = newAppState;
    });
  }

  void longIncrement(int by) async {
    await Future.delayed(const Duration(seconds: 2), (() {
      final int newCount = appState.counter + by;
      final newAppState = appState.copyWith(counter: newCount, isPressed: true);

      setState(() {
        appState = newAppState;
      });
    }));
  }

  void stopIncrement() {
    final newAppState = appState.copyWith(isPressed: false);
    setState(() {
      appState = newAppState;
    });
  }

  void decrement(int by) {
    final int newCount = appState.counter - by;
    final newAppState = appState.copyWith(counter: newCount);

    setState(() {
      appState = newAppState;
    });
  }

  void changeColor(MaterialColor color) {
    final newAppState = appState.copyWith(color: color);

    setState(() {
      appState = newAppState;
    });
  }
}
