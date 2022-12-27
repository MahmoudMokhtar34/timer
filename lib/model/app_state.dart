// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class AppState {
  final int counter;
  final MaterialColor color;
  final bool isPressed;
  AppState({
    this.counter = 0,
    this.color = Colors.green,
    this.isPressed = false,
  });

  AppState copyWith({
    int? counter,
    MaterialColor? color,
    bool? isPressed,
  }) {
    return AppState(
      counter: counter ?? this.counter,
      color: color ?? this.color,
      isPressed: isPressed ?? this.isPressed,
    );
  }

  @override
  String toString() =>
      'AppState(counter: $counter, color: $color, isPressed: $isPressed)';

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.counter == counter &&
        other.color == color &&
        other.isPressed == isPressed;
  }

  @override
  int get hashCode => counter.hashCode ^ color.hashCode ^ isPressed.hashCode;

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'counter': counter,
  //     'color': color.toMap(),
  //     'isPressed': isPressed,
  //   };
  // }

  // factory AppState.fromMap(Map<String, dynamic> map) {
  //   return AppState(
  //     counter: map['counter'] as int,
  //     color: MaterialColor.fromMap(map['color'] as Map<String,dynamic>),
  //     isPressed: map['isPressed'] as bool,
  //   );
  // }

  //String toJson() => json.encode(toMap());

  //factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source) as Map<String, dynamic>);
}
