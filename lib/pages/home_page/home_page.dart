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
            color: Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//Timer
                Expanded(
                  flex: 20,
                  child: timer(provider, appState),
                ),
//List of sessions,
                Expanded(
                  flex: 65,
                  child: sessionsList(appState, provider),
                ),
//Statistics,
                Expanded(
                  flex: 15,
                  child: statistics(provider, appState),
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

  Widget timer(Provider provider, AppState appState) {
    Widget start = appState.isStarted
        ? const SizedBox()
        : const Center(
            child: SizedBox.expand(
                child: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.play_arrow,
              size: 120,
            ),
          )));
    Widget resume = appState.isStarted ? const Icon(Icons.pause) : Container();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimeWidget(
                  provider: provider,
                  appState: appState,
                  textStyle: const TextStyle(fontSize: 70),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: resume,
        ),
        start,
        GestureDetector(
          onTap: () {
            provider.startPAuseResume(
                appState: appState, provider: provider, setState: setState);
            print('### press ${appState.press++}');
          },
        )
      ],
    );
  }

  Container sessionsList(AppState appState, Provider provider) {
    return Container(
      color: Colors.grey[50],
      width: double.infinity,
      alignment: Alignment.topCenter,
      child:
          //...appState.sessions.map((e) => Text(e.toString())),
          ListView.builder(
        itemCount: appState.sessions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            key: ObjectKey(appState.sessions[index]),
            child: ListTile(
              leading: Text('${index + 1}'),
              title: Text(provider.formatDuration(appState.sessions[index])),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return deleteDialog(
                              index,
                              provider,
                              appState,
                              context,
                              () => provider.deleteOneSession(
                                    appState,
                                    index,
                                    setState,
                                  ),
                              'Confirm to delete Session ${index + 1}');
                        }));
                  },
                  icon: const Icon(Icons.delete)),
            ),
          );
        },
      ),
    );
  }

  Widget deleteDialog(int? index, Provider provider, AppState appState,
      BuildContext context, Function delete, String message) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsetsDirectional.all(30),
          child: Column(
            children: [
              Text(message),
              TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                onPressed: () {
                  delete();
                  Navigator.pop(context);
                },
              )
            ],
          )),
    );
  }

  Container statistics(Provider provider, AppState appState) {
    return Container(
      color: Colors.blue[50],
      width: double.infinity,
      alignment: Alignment.center,
      child: FittedBox(
        child: Column(
          children: [
            Text('Sum ${provider.formatDuration(provider.sumSessions())}'),
            Text('Avg ${provider.formatDuration(provider.avgSessions())}'),
            Text('number of sess ${appState.sessions.length}'),
            const Text(
                'editable max min limit // ask befor delete//coloring above limit'),
          ],
        ),
      ),
    );
  }

  Container buttons(Provider provider, AppState appState) {
    return Container(
      color: Colors.green[50],
      width: double.infinity,
      alignment: Alignment.center,
      child: FittedBox(
        child: Row(
          children: <Widget>[
            //Stop button
            ElevatedButton(
              onPressed: () {
                provider.stop(appState: appState, setState: setState);
                print('### press ${appState.press++}');
              },
              child: const Text('Stop'),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
                key: const ValueKey('deleteSessions'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return deleteDialog(null, provider, appState, context,
                            () {
                          provider.deleteSessions(
                            appState: appState,
                            setState: setState,
                          );
                          appState.test = 0;
                          appState.test2 = 0;
                          appState.press = 0;
                        }, 'Confirm to delete ALL Session');
                      });
                },
                child: const Text('clear list')),
          ],
        ),
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
