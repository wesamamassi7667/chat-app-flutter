

import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerAction{
  Timer? _timer;
  final int milliSeconds;
 TimerAction({required this.milliSeconds});

   run(VoidCallback action){
     _timer?.cancel();
    _timer=Timer(Duration(milliseconds: milliSeconds),action);
  }

}

