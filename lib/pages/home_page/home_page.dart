import 'package:flutter/material.dart';
import 'package:timer/pages/home_page/time_widget.dart';

import '../../model/app_state.dart';
import '../../model/inherited_state.dart';
import '../../model/state_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider provider = InheritedState.of(context) as Provider;
    AppState appState = provider.appState;
    print('### build 1 ${appState.test++}');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Timer'),
        ),
        body:
//Body
            SafeArea(
          child: Container(
            width: double.infinity,
            color: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//Timer
                Expanded(
                  flex: 15,
                  child: timer(provider, appState),
                ),
//List of sessions,
                Expanded(
                  flex: 65,
                  child: sessionsList(appState, provider),
                ),
//Statistics,
                Expanded(
                  flex: 10,
                  child: statistics(provider),
                ),
//buttons,
                Expanded(
                  flex: 10,
                  child: buttons(provider, appState),
                ),
              ],
            ),
          ),
        ));
  }

  Container timer(Provider provider, AppState appState) {
    return Container(
        color: Colors.amber[50],
        width: double.infinity,
        alignment: Alignment.center,
        child: TimeWidget(provider: provider, appState: appState));
  }

  Container sessionsList(AppState appState, Provider provider) {
    return Container(
      color: Colors.amber,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          const Text('list'),
          //...appState.sessions.map((e) => Text(e.toString())),
          Expanded(
            child: ListView.builder(
              itemCount: appState.sessions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          provider.formatDuration(appState.sessions[index]))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container statistics(Provider provider) {
    return Container(
      color: Colors.blue[50],
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('Sum ${provider.formatDuration(provider.sumSessions())}'),
          Text('Sum ${provider.sumSessions().inSeconds}'),
        ],
      ),
    );
  }

  Container buttons(Provider provider, AppState appState) {
    return Container(
      color: Colors.green[50],
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Start / Pause / Resume Button
          ElevatedButton(
            onPressed: () {
              provider.startPAuseResume(
                  appState: appState, provider: provider, setState: setState);
              print('### press ${appState.press++}');
            },
            child: Text(appState.isStarted
                ? 'pause'
                : (appState.sessionDuration == AppState.zeroingDuration
                    ? 'Start'
                    : 'Resume')),
          ),
          //Stop button
          ElevatedButton(
            onPressed: () {
              provider.stop(appState: appState, setState: setState);
              print('### press ${appState.press++}');
            },
            child: const Text('Stop'),
          ),
          ElevatedButton(
              onPressed: () {
                provider.deleteSessions(appState: appState, setState: setState);
                appState.test = 0;
                appState.test2 = 0;
                appState.press = 0;
              },
              child: const Text('clear list')),
        ],
      ),
    );
  }
}

//  Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: const [
//           Expanded(
//             flex: 1,
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(5)),
//                 color: Colors.lightBlueAccent,
//               ),
//               child: Center(
// //Controls & List
//                 child: InheritedTimer(),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//         ],
//       ),
