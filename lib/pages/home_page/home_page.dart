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
          actions: [
            IconButton(
                onPressed: (() {
                  showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return Settings(
                          appState: appState,
                          provider: provider,
                          setState: setState,
                        );
                      });
                }),
                icon: const Icon(Icons.settings))
          ],
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
              tileColor: appState.sessions[index] < appState.sessionLimit
                  ? Colors.red[100]
                  : null,
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Center(child: Text(message)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    onPressed: () {
                      delete();
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  Container statistics(Provider provider, AppState appState) {
    return Container(
        color: Colors.grey[200],
        //width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Card(
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'Sum\n ${provider.formatDuration(provider.sumSessions())}'),
                            ))),
                    Expanded(
                        child: Card(
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'Avg\n ${provider.formatDuration(provider.avgSessions())}'),
                            )))
                  ]),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Card(
                            color: Colors.grey[300],
                            child: Center(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'count\n ${appState.sessions.length}')))),
                    Expanded(
                        child: Card(
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'sess > limt\n ${appState.sessions.where((e) => e < appState.sessionLimit).length}'),
                            ))),
                  ]),
            ),
          ],
        )

        // Column(

        //   children: <Widget>[
        //     Expanded(
        //       child: Row(
        //         children: [
        //           Expanded(
        //             child: Card(
        //                 child: Text(
        //                     'Sum ${provider.formatDuration(provider.sumSessions())}')),
        //           ),
        //           Expanded(
        //             child: Card(
        //                 child: Text(
        //                     'Avg ${provider.formatDuration(provider.avgSessions())}')),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Expanded(
        //       child: Row(
        //         children: [
        //           Expanded(
        //               child:
        //                   Card(child: Text('count ${appState.sessions.length}'))),
        //           Expanded(
        //             child: Card(
        //               child: Text(
        //                   'sess > limt ${appState.sessions.where((e) => e < appState.sessionLimit).length}'),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  Widget buttons(Provider provider, AppState appState) {
    return Container(
      color: Colors.grey[300],
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
            Builder(builder: (context) {
              return ElevatedButton(
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
                          }, 'Confirm to delete ALL Sessions');
                        });
                  },
                  child: const Text('clear list'));
            }),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings(
      {super.key,
      required this.appState,
      required this.provider,
      required this.setState});
  final AppState appState;
  final Provider provider;
  final Function setState;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            //minutes
            children: <Widget>[
              IconButton(
                onPressed: () => setState(() {
                  newLimit(sessionLimit() - const Duration(minutes: 1));
                }),
                icon: const Icon(Icons.remove),
              ),
              Text(
                  '${sessionLimit().inMinutes >= 60 ? sessionLimit().inMinutes % 60 : sessionLimit().inMinutes}'),
              IconButton(
                onPressed: () => setState(() {
                  newLimit(sessionLimit() + const Duration(minutes: 1));
                }),
                icon: const Icon(Icons.add),
              ),

              const SizedBox(
                width: 20,
              ),
              //seconds
              IconButton(
                onPressed: () => setState(() {
                  newLimit(sessionLimit() - const Duration(seconds: 1));
                }),
                icon: const Icon(Icons.remove),
              ),
              Text(
                  '${sessionLimit().inSeconds >= 60 ? sessionLimit().inSeconds % 60 : sessionLimit().inSeconds}'),
              IconButton(
                onPressed: () => setState(() {
                  newLimit(sessionLimit() + const Duration(seconds: 1));
                }),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                //updating home page wih the new limi before closing bottom sheet
                widget.setState(() {});
                Navigator.of(context).pop();
              },
              child: const Text('Done'))
        ],
      ),
    );
  }

  //get the current limit
  Duration sessionLimit() => widget.appState.sessionLimit;
  //update to new limit
  void newLimit(Duration duration) {
    if (duration < AppState.zeroingDuration) return;
    widget.appState.sessionLimit = duration;
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
