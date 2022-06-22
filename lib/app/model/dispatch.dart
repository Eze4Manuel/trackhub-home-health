
class Dispatch {
  String? companyId;
  String? companyName;
  String? recipientCompanyId;
  String? requestId;
  String? requestName;
  String? requestEmail;
  String? requestPhoneNumber;
  String? requestPartnerType;
  List? requestDetails;
  String? dispatchStatus;
  String? dispatchInfo;
  String? pickupAddress;
  String? dropoffAddress;
  double? pickupLatitude;
  double? pickupLongitude;
  double? dropoffLatitude;
  double? dropoffLongitude;
  String? dropoffName;
  String? dropoffArea;
  String? dropoffCity;
  String? paymentStructureType;
  double? paymentStructureAmount;



  Dispatch(
      {
        this.companyId,
        this.companyName,
        this.recipientCompanyId,
        this.requestId,
        this.requestName,
        this.requestEmail,
        this.requestPhoneNumber,
        this.requestPartnerType,
        this.requestDetails,
        this.dispatchStatus,
        this.dispatchInfo,
        this.pickupAddress,
        this.dropoffAddress,
        this.pickupLatitude,
        this.pickupLongitude,
        this.dropoffLatitude,
        this.dropoffLongitude,
        this.dropoffName,
        this.dropoffArea,
        this.dropoffCity,
        this.paymentStructureType,
        this.paymentStructureAmount,
      });

  Dispatch.fromJson(Map<String, String> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    recipientCompanyId = json['recipientCompanyId'];
    requestId = json['requestId'];
    requestName = json['requestName'];
    requestEmail = json['requestEmail'];
    requestPhoneNumber = json['requestPhoneNumber'];
    requestPartnerType = json['requestPartnerType'];
    requestDetails = json['requestDetails'] as List?;
    dispatchStatus = json['dispatchStatus'];
    dispatchInfo = json['dispatchInfo'];
    pickupAddress = json['pickupAddress'];
    dropoffAddress = json['dropoffAddress'];
    pickupLatitude = json['pickupLatitude'] as double?;
    pickupLongitude = json['pickupLongitude'] as double?;
    dropoffLatitude = json['dropoffLatitude'] as double?;
    dropoffLongitude = json['dropoffLongitude'] as double?;
    dropoffName = json['dropoffName'];
    dropoffArea = json['dropoffArea'];
    dropoffCity = json['dropoffCity'];
    paymentStructureType = json['paymentStructureType'];
    paymentStructureAmount = json['paymentStructureAmount'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['company_id'] = companyId ?? '';
    data['company_name'] = companyName ?? '';
    data['recipient_company_id'] = recipientCompanyId ?? '';
    data['request_id'] = requestId ?? '';
    data['request_name'] = requestName ?? '';
    data['request_email'] = requestEmail ?? '';
    data['request_phone_number'] = requestPhoneNumber ?? '';
    data['request_partner_type'] = requestPartnerType ?? '';
    data['request_details'] = requestDetails ?? '';
    data['dispatch_status'] = dispatchStatus ?? '';
    data['dispatch_info'] = dispatchInfo ?? '';
    data['pickup_address'] = pickupAddress ?? '';
    data['dropoff_address'] = dropoffAddress;
    data['pickup_latitude'] = pickupLatitude;
    data['pickup_longitude'] = pickupLongitude;
    data['dropoff_latitude'] = dropoffLatitude;
    data['dropoff_longitude'] = dropoffLongitude;
    data['dropoff_name'] = dropoffName;
    data['dropoff_area'] = dropoffArea;
    data['dropoff_city'] = dropoffCity;
    data['payment_structure_type'] = paymentStructureType;
    data['payment_structure_amount'] = paymentStructureAmount;

    return data;
  }
}
