import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// TODOクラスの指定
@immutable
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  /// 文字変換する関数
  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

/// Notifierで検知対象とする
class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  /// TODOの追加。IDと説明の追加
  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  /// 完了のオンオフ設定
  void toggle(String id) {
    state = [
      /// リストを総浚いし、IDが同じものは更新。違うものはそのまま。
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  /// 編集（idとdescriptionを受け取る）
  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  /// スワイプしたら削除
  /// ID意外をセットすることでremoveを再現
  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
