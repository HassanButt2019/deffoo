class GetTourListModel {
  bool? status;
  List<Data>? data;
  String? meassge;
  String? imagePath;

  GetTourListModel({this.status, this.data, this.meassge, this.imagePath});

  GetTourListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meassge = json['meassge'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['meassge'] = this.meassge;
    data['image_path'] = this.imagePath;
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? cityId;
  String? activityName;
  String? contactName;
  String? contactNo;
  String? emailId;
  String? startDate;
  String? endDate;
  String? address;
  String? briefOverview;
  String? termCondition;
  String? thingsCarry;
  String? ratePerPerson;
  String? accountName;
  String? accountNo;
  String? bankName;
  String? ifscCode;
  String? image;
  String? createdAt;
  String? status;
  String? name;
  String? cityCode;
  String? stateId;

  Data(
      {this.id,
        this.userId,
        this.cityId,
        this.activityName,
        this.contactName,
        this.contactNo,
        this.emailId,
        this.startDate,
        this.endDate,
        this.address,
        this.briefOverview,
        this.termCondition,
        this.thingsCarry,
        this.ratePerPerson,
        this.accountName,
        this.accountNo,
        this.bankName,
        this.ifscCode,
        this.image,
        this.createdAt,
        this.status,
        this.name,
        this.cityCode,
        this.stateId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['tour_id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    activityName = json['activity_name'];
    contactName = json['contact_name'];
    contactNo = json['contact_no'];
    emailId = json['email_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    address = json['address'];
    briefOverview = json['brief_overview'];
    termCondition = json['term_condition'];
    thingsCarry = json['things_carry'];
    ratePerPerson = json['rate_per_person'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    image = json['image'];
    createdAt = json['created_at'];
    status = json['status'];
    name = json['name'];
    cityCode = json['city_code'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['activity_name'] = this.activityName;
    data['contact_name'] = this.contactName;
    data['contact_no'] = this.contactNo;
    data['email_id'] = this.emailId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['address'] = this.address;
    data['brief_overview'] = this.briefOverview;
    data['term_condition'] = this.termCondition;
    data['things_carry'] = this.thingsCarry;
    data['rate_per_person'] = this.ratePerPerson;
    data['account_name'] = this.accountName;
    data['account_no'] = this.accountNo;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['name'] = this.name;
    data['city_code'] = this.cityCode;
    data['state_id'] = this.stateId;
    return data;
  }
}
