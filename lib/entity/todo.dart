// Todoのクラスとメソッドを定義
class Todo {
  final String content; // TODOの内容
  final bool done; // 完了かどうか
  final DateTime timestamp; // 登録日時
  final String id; // 識別ID

  // 全て必須
  Todo({
    required this.content,
    required this.done,
    required this.timestamp,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          done == other.done &&
          timestamp == other.timestamp &&
          id == other.id);

  @override
  int get hashCode => content.hashCode ^ done.hashCode ^ timestamp.hashCode ^ id.hashCode;

  // TODOの内容を文字列に変換
  @override
  String toString() {
    return 'Todo{' + ' content: $content,' + ' done: $done,' + ' timestamp: $timestamp,' + ' id: $id,' + '}';
  }

  // 編集作業等で用いる
  Todo copyWith({
    String? content,
    bool? done,
    DateTime? timestamp,
    String? id,
  }) {
    return Todo(
      content: content ?? this.content,
      done: done ?? this.done,
      timestamp: timestamp ?? this.timestamp,
      id: id ?? this.id,
    );
  }

  // TODOデータをMap表示する
  Map<String, dynamic> toMap() {
    return {
      'content': this.content,
      'done': this.done,
      'timestamp': this.timestamp.toIso8601String(),
      'id': this.id,
    };
  }

  //ファクトリーコンストラクタ
  // 常に新規インスタンス生成されては困る場合、
  // メソッド名が重複しそうな場合に活用すると良い。
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      content: map['content'] as String,
      done: map['done'] as bool,
      timestamp: DateTime.parse(map['timestamp']),
      id: map['id'] as String,
    );
  }
}
