class GetCyclingListModel {
  bool? status;
  List<Data>? data;
  String? meassge;
  String? imagePath;

  GetCyclingListModel({this.status, this.data, this.meassge, this.imagePath});

  GetCyclingListModel.fromJson(Map<String, dynamic> json) {
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
  String? contactNo;
  String? contactName;
  String? emailId;
  String? address;
  String? noOfBikes;
  String? briefOverview;
  String? startDate;
  String? endDate;
  String? rentPerPerson;
  String? inclusion;
  String? exclusion;
  String? termCondition;
  String? accountNo;
  String? accountName;
  String? bankName;
  String? ifscCode;
  String? image;
  String? status;
  String? createdAt;
  String? name;
  String? cityCode;
  String? stateId;

  Data(
      {this.id,
        this.userId,
        this.cityId,
        this.activityName,
        this.contactNo,
        this.contactName,
        this.emailId,
        this.address,
        this.noOfBikes,
        this.briefOverview,
        this.startDate,
        this.endDate,
        this.rentPerPerson,
        this.inclusion,
        this.exclusion,
        this.termCondition,
        this.accountNo,
        this.accountName,
        this.bankName,
        this.ifscCode,
        this.image,
        this.status,
        this.createdAt,
        this.name,
        this.cityCode,
        this.stateId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['cycling_list_id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    activityName = json['activity_name'];
    contactNo = json['contact_no'];
    contactName = json['contact_name'];
    emailId = json['email_id'];
    address = json['address'];
    noOfBikes = json['no_of_bikes'];
    briefOverview = json['brief_overview'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    rentPerPerson = json['rent_per_person'];
    inclusion = json['inclusion'];
    exclusion = json['exclusion'];
    termCondition = json['term_condition'];
    accountNo = json['account_no'];
    accountName = json['account_name'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
    cityCode = json['city_code'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cycling_list_id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['activity_name'] = this.activityName;
    data['contact_no'] = this.contactNo;
    data['contact_name'] = this.contactName;
    data['email_id'] = this.emailId;
    data['address'] = this.address;
    data['no_of_bikes'] = this.noOfBikes;
    data['brief_overview'] = this.briefOverview;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['rent_per_person'] = this.rentPerPerson;
    data['inclusion'] = this.inclusion;
    data['exclusion'] = this.exclusion;
    data['term_condition'] = this.termCondition;
    data['account_no'] = this.accountNo;
    data['account_name'] = this.accountName;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['city_code'] = this.cityCode;
    data['state_id'] = this.stateId;
    return data;
  }
}
