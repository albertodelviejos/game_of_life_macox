import 'dart:async';

class TimerSingleton{
  static TimerSingleton? _instance;
  static TimerSingleton get instance => _instance ??= TimerSingleton._();
  TimerSingleton._();

  Timer? _timer;
  int _tick = 0;
  int get tick => _tick;

  void startTimer(){
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _tick++;
    });
  }

  void stopTimer(){
    _timer?.cancel();
  }
}