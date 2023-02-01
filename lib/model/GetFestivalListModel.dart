class GetFestivalListModel {
  bool? status;
  List<Data>? data;
  String? meassge;
  String? imagePath;

  GetFestivalListModel({this.status, this.data, this.meassge, this.imagePath});

  GetFestivalListModel.fromJson(Map<String, dynamic> json) {
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
  String? address;
  String? noOfDay;
  String? briefOverview;
  String? thingsCarry;
  String? inclusion;
  String? exclusion;
  String? termCondition;
  String? rentPerPerson;
  String? startDate;
  String? endDate;
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
        this.address,
        this.noOfDay,
        this.briefOverview,
        this.thingsCarry,
        this.inclusion,
        this.exclusion,
        this.termCondition,
        this.rentPerPerson,
        this.startDate,
        this.endDate,
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
    id = json['festival_id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    activityName = json['activity_name'];
    contactName = json['contact_name'];
    contactNo = json['contact_no'];
    emailId = json['email_id'];
    address = json['address'];
    noOfDay = json['no_of_day'];
    briefOverview = json['brief_overview'];
    thingsCarry = json['things_carry'];
    inclusion = json['inclusion'];
    exclusion = json['exclusion'];
    termCondition = json['term_condition'];
    rentPerPerson = json['rent_per_person'];
    startDate = json['start_date'];
    endDate = json['end_date'];
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
    data['festival_id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['activity_name'] = this.activityName;
    data['contact_name'] = this.contactName;
    data['contact_no'] = this.contactNo;
    data['email_id'] = this.emailId;
    data['address'] = this.address;
    data['no_of_day'] = this.noOfDay;
    data['brief_overview'] = this.briefOverview;
    data['things_carry'] = this.thingsCarry;
    data['inclusion'] = this.inclusion;
    data['exclusion'] = this.exclusion;
    data['term_condition'] = this.termCondition;
    data['rent_per_person'] = this.rentPerPerson;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
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
