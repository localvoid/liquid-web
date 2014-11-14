library liquid_web.pages.home;

import 'dart:html';
import 'package:observe/observe.dart';
import 'package:liquid/liquid.dart';
import 'package:liquid_web/examples/hello.dart';
import 'package:liquid_web/examples/timer.dart';
import 'package:liquid_web/examples/todo.dart';

void main() {
  injectComponent(new HelloMessage(null, 'World'),
      querySelector('#demo-hello'));

  injectComponent(new TimerView(null),
      querySelector('#demo-timer'));

  injectComponent(new TodoApp(null, new ObservableList()),
      querySelector('#demo-todo'));
}