class Purchase {
  String? created;
  int? stock;
  String? productId;
  String? id;

  Purchase({
    this.created,
    this.stock,
    this.productId,
    this.id,
  });

  Purchase.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    stock = json['stock'];
    productId = json['productId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created'] = created;
    data['stock'] = stock;
    data['productId'] = productId;
    data['id'] = id;
    return data;
  }
}
