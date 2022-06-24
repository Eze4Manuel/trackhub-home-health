


class Test {
  String? specimen;
  String? name;
  String? noOfBottles;
  String? moreInfo;
  String? price;
  Map<String, dynamic>? testPrices;

  Test(
      {
        this.specimen,
        this.name,
        this.noOfBottles,
        this.moreInfo,
        this.price,
        this.testPrices
      });

  Test.fromJson(Map<String, String> json) {
    specimen = json['specimen'];
    name = json['name'];
    noOfBottles = json['noOfBottles'];
    moreInfo = json['moreInfo'];
    price = json['price'];
    testPrices = json!['testPrices'] as Map<String, dynamic>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['specimen'] = specimen ?? '';
    data['name'] = name ?? '';
    data['noOfBottles'] = noOfBottles ?? '';
    data['moreInfo'] = moreInfo ?? '';
    data['price'] = price ?? '';
    data['testPrices'] = testPrices;
    return data;
  }
}
