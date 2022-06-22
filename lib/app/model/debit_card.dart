


class DebitCard {
  String? card_name;
  String? card_number;
  String? month;
  String? year;
  String? ccv;

  DebitCard(
      {
        this.card_name,
        this.card_number,
        this.month,
        this.year,
        this.ccv
      });

  DebitCard.fromJson(Map<String, String> json) {
    card_name = json['card_name'];
    card_number = json['card_number'];
    month = json['month'];
    year = json['year'];
    ccv = json['ccv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_name'] = card_name ?? '';
    data['card_number'] = card_number ?? '';
    data['month'] = month ?? '';
    data['year'] = year ?? '';
    data['ccv'] = ccv;
    return data;
  }
}
