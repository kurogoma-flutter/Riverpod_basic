import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../view/todo_view.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: SimpleTodo(),
      ),
    ),
  );
}
