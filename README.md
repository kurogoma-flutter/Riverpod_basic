# riverpod_train

Riverpodのと、ロジック切り分けについての学習<br>
あとついでにDartDataClassの凄さを体感

## TODOメモ
### 参考
こちらを参考にしました
https://github.com/ttlg/riverpod_todo

### ロジックについて個人的に学べたこと

### entity
データ型やインスタス生成ルールの定義
### repository
実際に行う処理のロジックを記述する
### provider
主に以下の2つだけまずは意識してみる
1. Stateの管理
2. Controllerの実装

#### 1. Stateの管理
実際の処理はrepositoryに記述と書いたが、あくまでrepositoryはStateで管理していないデータのに用いる。<br>
逆にproviderは、Stateに関わる処理を記述する。
#### 2. Controllerの実装
Controllerはファット化解消のために、「ただ処理を呼ぶ（命令する）」だけのものになるよう専念する。<br>
なので、entityやrepositoryに書いた処理を「呼ぶだけ」と言うことに専念したら良さそう。

## DartDataClassの凄さ
以下の記事を参考にさせていただきましたが、まさかモデルの準備がこれだけとは、、、
https://zenn.dev/kooooons/articles/0170d78a0eb55a

#### テストで生成したitem.dart
```dart:item.dart
class Item {
  int price;
  String name;

  int stock;
// ここまでしか書いてない。下は自動生成

//<editor-fold desc="Data Methods">

  Item({
    required this.price,
    required this.name,
    required this.stock,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item && runtimeType == other.runtimeType && price == other.price && name == other.name && stock == other.stock);

  @override
  int get hashCode => price.hashCode ^ name.hashCode ^ stock.hashCode;

  @override
  String toString() {
    return 'Item{' + ' price: $price,' + ' name: $name,' + ' stock: $stock,' + '}';
  }

  Item copyWith({
    int? price,
    String? name,
    int? stock,
  }) {
    return Item(
      price: price ?? this.price,
      name: name ?? this.name,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': this.price,
      'name': this.name,
      'stock': this.stock,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      price: map['price'] as int,
      name: map['name'] as String,
      stock: map['stock'] as int,
    );
  }

//</editor-fold>
}
```
