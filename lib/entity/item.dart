class Item {
  int price;
  String name;
  int stock;

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
