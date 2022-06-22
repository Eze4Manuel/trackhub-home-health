


class RequestDetail {
  String? nameOfPatient;
  String? specimenType;
  String? testType;
  String? noOfBottles;
  String? moreInfo;
  String? price;

  RequestDetail(
      {
        this.nameOfPatient,
        this.specimenType,
        this.testType,
        this.noOfBottles,
        this.moreInfo,
        this.price
      });

  RequestDetail.fromJson(Map<String, String> json) {
    nameOfPatient = json['nameOfPatient'];
    specimenType = json['specimenType'];
    testType = json['testType'];
    noOfBottles = json['noOfBottles'];
    moreInfo = json['moreInfo'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_of_patient'] = nameOfPatient ?? '';
    data['specimen_type'] = specimenType ?? '';
    data['test_type'] = testType ?? '';
    data['no_of_bottles'] = noOfBottles ?? '';
    data['more_info'] = moreInfo;
    data['price'] = price ?? '0';
    return data;
  }
}

