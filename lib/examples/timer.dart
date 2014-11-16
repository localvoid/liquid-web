library liquid_web.examples.timer;

import 'dart:async';
import 'package:liquid/liquid.dart';
import 'package:vdom/helpers.dart' as vdom;

class TimerView extends VComponent {
  int secondsElapsed = 0;
  Timer _timer;

  TimerView(Context context) : super('div', context);

  attached() {
    super.attached();
    _timer = new Timer.periodic(const Duration(seconds: 1), (_) {
      secondsElapsed++;
      invalidate();
    });
  }

  detached() {
    _timer.cancel();
    super.detached();
  }

  build() => vdom.div(0, [vdom.text(0, 'Seconds elapsed: $secondsElapsed')]);
}
