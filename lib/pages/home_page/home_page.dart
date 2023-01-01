import 'package:flutter/material.dart';
import 'package:timer/pages/home_page/timer_inherited.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: InheritedTimer()),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: TimesList()),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: Statistics()),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: const Center(child: Controls()),
            ),
          ),
        ],
      ),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('controls');
  }
}

class Statistics extends StatelessWidget {
  const Statistics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('statistics');
  }
}

class TimesList extends StatelessWidget {
  const TimesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('item'),
      ],
    );
  }
}
