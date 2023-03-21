class CreditCard {
  String? id;
  String? cardNumber;
  String? expiryDate;
  String? cardHolderName;
  String? cvvCode;

  CreditCard({
    this.id,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
  });

  CreditCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardNumber = json['cardNumber'];
    expiryDate = json['expiryDate'];
    cardHolderName = json['cardHolderName'];
    cvvCode = json['cvvCode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['cardNumber'] = cardNumber;
    data['expiryDate'] = expiryDate;
    data['cardHolderName'] = cardHolderName;
    data['cvvCode'] = cvvCode;
    return data;
  }
}
