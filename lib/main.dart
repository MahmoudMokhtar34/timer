
import 'package:flutter/material.dart';
import 'model/state_widget.dart';

import 'pages/home_page/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const StateWidget(
      child:  MaterialApp(
        title: 'Timer',
        home:  HomePage(),
      ),
    );
  }
}

