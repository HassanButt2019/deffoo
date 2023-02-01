class GetTrackModel {
  bool? status;
  List<Data>? data;
  String? meassge;
  String? path;

  GetTrackModel({this.status, this.data, this.meassge, this.path});

  GetTrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meassge = json['meassge'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['meassge'] = this.meassge;
    data['path'] = this.path;
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
  String? dayNo;
  String? nightNo;
  String? trackStartPoint;
  String? trackEndPoint;
  String? details;
  String? inclusion;
  String? exclusion;
  String? termCondition;
  String? ratePerPerson;
  String? items;
  String? addOn;
  String? startDate;
  String? endDate;
  String? accountName;
  String? accountNo;
  String? bankName;
  String? ifscCode;
  String? chaqueImage;
  String? image;
  String? status;
  String? createtAt;
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
        this.dayNo,
        this.nightNo,
        this.trackStartPoint,
        this.trackEndPoint,
        this.details,
        this.inclusion,
        this.exclusion,
        this.termCondition,
        this.ratePerPerson,
        this.items,
        this.addOn,
        this.startDate,
        this.endDate,
        this.accountName,
        this.accountNo,
        this.bankName,
        this.ifscCode,
        this.chaqueImage,
        this.image,
        this.status,
        this.createtAt,
        this.name,
        this.cityCode,
        this.stateId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['track_and_trails_id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    activityName = json['activity_name'];
    contactName = json['contact_name'];
    contactNo = json['contact_no'];
    emailId = json['email_id'];
    address = json['address'];
    dayNo = json['day_no'];
    nightNo = json['night_no'];
    trackStartPoint = json['track_start_point'];
    trackEndPoint = json['track_end_point'];
    details = json['details'];
    inclusion = json['inclusion'];
    exclusion = json['exclusion'];
    termCondition = json['term_condition'];
    ratePerPerson = json['rate_per_person'];
    items = json['items'];
    addOn = json['add_on'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    chaqueImage = json['chaque_image'];
    image = json['image'];
    status = json['status'];
    createtAt = json['createt_at'];
    name = json['name'];
    cityCode = json['city_code'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['track_and_trails_id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['activity_name'] = this.activityName;
    data['contact_name'] = this.contactName;
    data['contact_no'] = this.contactNo;
    data['email_id'] = this.emailId;
    data['address'] = this.address;
    data['day_no'] = this.dayNo;
    data['night_no'] = this.nightNo;
    data['track_start_point'] = this.trackStartPoint;
    data['track_end_point'] = this.trackEndPoint;
    data['details'] = this.details;
    data['inclusion'] = this.inclusion;
    data['exclusion'] = this.exclusion;
    data['term_condition'] = this.termCondition;
    data['rate_per_person'] = this.ratePerPerson;
    data['items'] = this.items;
    data['add_on'] = this.addOn;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['account_name'] = this.accountName;
    data['account_no'] = this.accountNo;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['chaque_image'] = this.chaqueImage;
    data['image'] = this.image;
    data['status'] = this.status;
    data['createt_at'] = this.createtAt;
    data['name'] = this.name;
    data['city_code'] = this.cityCode;
    data['state_id'] = this.stateId;
    return data;
  }
}
