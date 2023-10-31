import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalState model = GlobalState();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalState>(
        model: model,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text('Stateful Counter App')),
            body: Column(
              children: <Widget>[
                CounterList(),
              ],
            ),
          ),
        ));
  }
}

class CounterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalState model =
        ScopedModel.of<GlobalState>(context, rebuildOnChange: true);
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            model.addCounter();
          },
          child: Text('Add Counter'),
        ),
        ListView.builder(
          itemCount: model.counters.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CounterWidget(index: index);
          },
        ),
      ],
    );
  }
}

class CounterWidget extends StatelessWidget {
  final int index;

  CounterWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final GlobalState model =
        ScopedModel.of<GlobalState>(context, rebuildOnChange: true);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Value: ${model.counters[index]}'),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              model.incrementCounter(index);
            },
            child: Text('Increment'),
          ),
          ElevatedButton(
            onPressed: () {
              model.decrementCounter(index);
            },
            child: Text('Decrement'),
          ),
          ElevatedButton(
              onPressed: () {
                model.removeCounter(index);
              },
              child: Text("remove"))
        ],
      ),
    );
  }
}
