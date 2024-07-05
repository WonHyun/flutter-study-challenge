import 'package:rxdart/rxdart.dart';

class Debouncer {
  final Duration delay;
  final _controller = BehaviorSubject<String>();

  Stream<String> get stream => _controller.stream.debounceTime(delay);

  Debouncer(this.delay);

  void add(String value) {
    _controller.add(value);
  }
}
