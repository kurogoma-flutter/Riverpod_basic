import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/todo.dart';

final todoRepository = Provider.autoDispose<TodoRepository>((ref) => TodoRepositoryImpl(ref.read));

// Repositoryは実装ロジックを記載するが、抽象クラスには書かない。
abstract class TodoRepository {
  Future<List<Todo>> getTodoList();
  Future<void> saveTodoList(List<Todo> todoList);
}

// SharedPreferenceのキー
const _todoListKey = 'todoListKey';

// 抽象クラスをインターフェイスとして実装
class TodoRepositoryImpl implements TodoRepository {
  final Reader _read;
  TodoRepositoryImpl(this._read);

  // SharedPreferenceで保存したjsonデータを取得
  Future<List<Todo>> getTodoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> todoListJsonList = List<Map<String, dynamic>>.from(jsonDecode(prefs.getString(_todoListKey) ?? '[]'));
    return todoListJsonList.map((json) => Todo.fromMap(json)).toList();
  }

  // SharedPreferenceでJson形式にしたデータを保存
  Future<void> saveTodoList(List<Todo> todoList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_todoListKey, jsonEncode(todoList.map((todo) => todo.toMap()).toList()));
  }
}
