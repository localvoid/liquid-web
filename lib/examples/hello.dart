library liquid_web.examples.hello;

import 'package:liquid/liquid.dart';
import 'package:vdom/helpers.dart' as vdom;

class HelloMessage extends VComponent {
  final String name;

  HelloMessage(Context context, this.name) : super('div', context);

  // Each VDom Node should have key that is unique amongst its siblings.
  build() => vdom.div(0, [vdom.text(0, 'Hello $name!')]);
}
