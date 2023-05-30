class Purchase {
  DateTime? created;
  int? stock;
  String? productId;
  String? id;
  String? state;
  String? clientId;

  Purchase({
    this.created,
    this.stock,
    this.productId,
    this.id,
    this.state,
    this.clientId,
  });

  Purchase.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    stock = json['stock'];
    productId = json['productId'];
    id = json['id'];
    state = json['state'];
    clientId = json['clientId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created'] = created;
    data['stock'] = stock;
    data['productId'] = productId;
    data['id'] = id;
    data['state'] = state;
    data['clientId'] = clientId;
    return data;
  }
}
