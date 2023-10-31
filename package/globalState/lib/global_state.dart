library global_state;

import 'package:scoped_model/scoped_model.dart';

/// A Calculator.
class GlobalState extends Model {
  List<int> _counters = [0];

  List<int> get counters => _counters;

  void incrementCounter(int index) {
    if (index >= 0 && index < _counters.length) {
      _counters[index]++;
      notifyListeners();
    }
  }

  void decrementCounter(int index) {
    if (index >= 0 && index < _counters.length && _counters[index] > 0) {
      _counters[index]--;
      notifyListeners();
    }
  }

  void addCounter() {
    _counters.add(0);
    notifyListeners();
  }

  void removeCounter(int index) {
    _counters.removeAt(index);
    notifyListeners();
  }

  void reorderCounter(int oldIndex, int newIndex) {
    if (oldIndex != newIndex) {
      final item = _counters.removeAt(oldIndex);
      _counters.insert(newIndex, item);
      notifyListeners();
    }
  }

}
