import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entity/todo.dart';
import '../repository/todo_repository.dart';

// データのソート順の定義
enum SortOrder {
  ASC,
  DESC,
}

// ソートの状態管理。初期値はASC
final _sortOrderState = StateProvider<SortOrder>((ref) => SortOrder.ASC);
// TODOリストの状態管理。初期値はnull
final _todoListState = StateProvider<List<Todo>?>((ref) => null);

final sortedTodoListState = StateProvider<List<Todo>?>((ref) {
  final List<Todo>? todoList = ref.watch(_todoListState);

  // watchでstateを覗ける。ASCかDESCでリストを並び替える。
  if (ref.watch(_sortOrderState) == SortOrder.ASC) {
    todoList?.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  } else {
    todoList?.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }
  return todoList;
});

/// ユーザーが別画面に遷移して戻ってきたらステートを破棄する
final todoViewController = Provider.autoDispose((ref) => TodoViewController(ref.read));

class TodoViewController {
  // Providerへのアクセスに用いる
  final Reader _read;
  TodoViewController(this._read);

  Future<void> initState() async {
    _read(_todoListState.notifier).state = await _read(todoRepository).getTodoList();
  }

  // providerのアクセスを断ち切る
  void dispose() {
    _read(_todoListState)?.clear();
  }

  // Repositoryを呼び出す
  // モデルの処理を呼ぶだけ（Controllerなので）
  Future<void> addTodo(TextEditingController textController) async {
    final String text = textController.text;
    if (text.trim().isEmpty) {
      return;
    }
    textController.text = '';
    final now = DateTime.now();
    final newTodo = Todo(
      content: text,
      done: false,
      timestamp: now,
      id: "${now.millisecondsSinceEpoch}",
    );
    final List<Todo> newTodoList = [newTodo, ...(_read(_todoListState) ?? [])];
    _read(_todoListState.notifier).state = newTodoList;
    await _read(todoRepository).saveTodoList(newTodoList);
  }

  //
  Future<void> toggleDoneStatus(Todo todo) async {
    final List<Todo> newTodoList = [...(_read(_todoListState) ?? []).map((e) => (e.id == todo.id) ? e.copyWith(done: !e.done) : e)];
    _read(_todoListState.notifier).state = newTodoList;
    await _read(todoRepository).saveTodoList(newTodoList);
  }

  // ソートのASC ⇆ DESCの切り替え
  void toggleSortOrder() {
    _read(_sortOrderState.notifier).state = _read(_sortOrderState) == SortOrder.ASC ? SortOrder.DESC : SortOrder.ASC;
  }
}
