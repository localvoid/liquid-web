library liquid_web.examples.todo;

import 'dart:async';
import 'package:liquid/liquid.dart';
import 'package:liquid/forms.dart' as vdom;
import 'package:vdom/helpers.dart' as vdom;
import 'package:observe/observe.dart';

class TodoItem {
  static int _nextId = 0; // auto-incremental unique key
  final int id;
  final String title;

  TodoItem(this.title) : id = _nextId++;
}

class TodoList extends VComponent {
  final List items;

  TodoList(Context context, this.items) : super('ul', context);

  build() =>
      vdom.ul(0, items.map((i) => vdom.li(i.id, [vdom.t(i.title)])).toList());

  /// Constructor for Virtual DOM Nodes, it is just a convention.
  ///
  /// When [component] argument is null, it means that component doesn't exist
  /// and should be created, otherwise it means that it is already exist and
  /// its state is moved from the previous vdom tree to the new one.
  static virtual(Object key, List items) {
    return new VDomComponent(key, (component, context) {
      if (component == null) {
        return new TodoList(context, items);
      } else {
        component.update();
      }
    });
  }
}

class TodoApp extends VComponent {
  final ObservableList items;
  StreamSubscription _sub;
  vdom.TextInput _input;

  TodoApp(Context context, this.items) : super('div', context) {
    Zone.ROOT.run(() {
      element.onClick.matches('button').listen((e) {
        if (_input.value.isNotEmpty) {
          items.add(new TodoItem(_input.value));
        }
        e.preventDefault();
        e.stopPropagation();
      });
    });
  }

  attached() {
    super.attached();
    Zone.ROOT.run(() => _sub = items.changes.listen((_) => invalidate()));
  }

  detached() {
    _sub.cancel();
    super.detached();
  }

  build() {
    final header = vdom.h3(#header, [vdom.t('TODO')]);
    final list = TodoList.virtual(#list, items);
    _input = new vdom.TextInput(#input);
    final form = vdom.form(#form, [
      _input,
      vdom.button(#button, [vdom.t('Add # ${items.length + 1}')])
    ]);

    return vdom.div(0, [header, list, form]);
  }
}
