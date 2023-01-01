import 'package:flutter/material.dart';
import 'package:timer/model/app_state.dart';
import 'package:timer/model/inherited_state.dart';
import 'package:timer/model/state_widget.dart';

class InheritedTimer extends StatefulWidget {
  const InheritedTimer({
    Key? key,
  }) : super(key: key);

  @override
  State<InheritedTimer> createState() => _InheritedTimerState();
}

class _InheritedTimerState extends State<InheritedTimer> {
  @override
  Widget build(BuildContext context) {
    Provider provider = InheritedState.of(context) as Provider;
    AppState appState = provider.appState;

    return Column(
      children: [
        Text(
          'time ${provider.formatDuration(appState.sessionDuration + appState.lapDuration)}',
        ),
//Start / Pause / Resume Button
        ElevatedButton(
          onPressed: () {
            provider.startPAuseResume(
                appState: appState, provider: provider, setState: setState);
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
            print('### ${appState.sessions}');
          },
          child: const Text('Stop'),
        ),

        Text(
            'total session time ${provider.formatDuration(appState.sessionDuration)}'),
        Builder(builder: (context) {
          return ElevatedButton(
              onPressed: () {
                provider.deleteSessions(appState: appState, setState: setState);
              },
              child: const Text('clear list'));
        }),
        //...appState.sessions.map((e) => Text(e.toString()))
        ...appState.sessions.map((e) => Text(e.toString())),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Sum ${provider.sumSessions().inSeconds}'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Sum ${provider.avgSessions().inSeconds}'),
        ),
        //: ${timePassed.inMinutes} :${timePassed.inSeconds}'
      ],
    );
  }
}

//TODO make a stateful widget and pass its state.set state method to the 
//activate timer method in the start button
//TODO test inherited widget change i it activates timer
//TODO make the activate timer in the buld but call timer.cancel before it to avoid multi calling(recursion)


//TODO separte timer widget & test isStated change to activate and send their own set state method
//or  notify other widget when press buttton to set their state
//or add a listener to a variable