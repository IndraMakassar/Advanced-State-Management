import 'package:flutter/material.dart';
import 'package:global_state/global_state.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalState model = GlobalState();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalState>(
        model: model,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Stateful Counter App')),
            body: const SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CounterList(),
                ],
              ),
            ),
          ),
        ));
  }
}

class CounterList extends StatelessWidget {
  const CounterList({super.key});

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
          child: const Text('Add Counter'),
        ),
        ReorderableListView.builder(
          itemCount: model.counters.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CounterWidget(index: index, key: ValueKey(index));
          },
          onReorder: (int oldIndex, int newIndex) {
            model.reorderCounter(oldIndex, newIndex);
          },
        ),
      ],
    );
  }
}

class CounterWidget extends StatelessWidget {
  final int index;
  final Key key;

  CounterWidget({required this.index, required this.key});

  @override
  Widget build(BuildContext context) {
    final GlobalState model =
        ScopedModel.of<GlobalState>(context, rebuildOnChange: true);
    return Card(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Counter: $index'),
                  Text('Value: ${model.counters[index]}'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          model.incrementCounter(index);
                        },
                        child: const Text('Increment'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          model.decrementCounter(index);
                        },
                        child: const Text('Decrement'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            model.removeCounter(index);
                          },
                          child: const Text("remove")),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
