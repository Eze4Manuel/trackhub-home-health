


class Account {
  String? first_name;
  String? last_name;
  String? email;
  String? phone_number;
  String? username;
  String? more_info;
  String? address;
  String? partner_type;
  String? password;
  String? dob;
  String? gender;

  Account(
      {
        this.first_name,
        this.last_name,
        this.email,
        this.phone_number,
        this.username,
        this.more_info,
        this.address,
        this.password});

  Account.profileUpdate(
      {
        this.first_name,
        this.last_name,
        this.phone_number,
        this.username,
        this.gender,
        this.dob});


  Account.fromJson(Map<String, String> json) {
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
    phone_number = json['phone_number'];
    address = json['address'];
    username = json['username'];
    more_info = json['more_info'];
    password = json['password'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, String>{};
    data['first_name'] = first_name ?? '';
    data['last_name'] = last_name ?? '';
    data['email'] = email ?? '';
    data['phone_number'] = phone_number ?? '';
    data['username'] = username ?? '';
    data['more_info'] = more_info ?? '';
    data['address'] = address ?? '';
    data['partner_type'] = 'customer';
    data['password'] = password ?? '';
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = <String, String>{};
    data['first_name'] = first_name ?? '';
    data['last_name'] = last_name ?? '';
    data['phone_number'] = phone_number ?? '';
    data['username'] = username ?? '';
    data['gender'] = gender ?? '';
    data['dob'] = dob ?? '';
    return data;
  }
}
