class CardModel {
  final int id;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cardType;
  final String logoUrl;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cardType,
    required this.logoUrl,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      cardNumber: json['cardNumber'],
      cardHolder: json['cardHolder'],
      expiryDate: json['expiryDate'],
      cardType: json['cardType'],
      logoUrl: json['logoUrl'],
    );
  }
}
