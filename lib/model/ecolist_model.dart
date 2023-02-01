class EcoModel {
  String? id;
  String? cityId;
  String? catId;
  String? hostId;
  String? title;
  String? contactName;
  String? contact;
  String? email;
  String? address;
  String? type;
  String? typeName;
  String? checkIn;
  String? checkOut;
  String? internet;
  String? others;
  String? roomType;
  String? roomTypeName;
  String? rentRoom;
  String? bedroom;
  String? tv;
  String? roomHeater;
  String? toilet;
  String? hotDrinking;
  String? noOfRoom;
  String? description;
  String? propertyImage;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? ifscCode;
  String? cancelChaque;
  String? createdAt;
  String? status;
  String? propertyId;
  String? creatDate;
  String? name;
  String? cityCode;
  String? stateId;
  String? rating;
  EcoModel(
      {this.id,
        this.cityId,
        this.catId,
        this.hostId,
        this.title,
        this.contactName,
        this.contact,
        this.email,
        this.address,
        this.type,
        this.typeName,
        this.checkIn,
        this.checkOut,
        this.internet,
        this.others,
        this.roomType,
        this.roomTypeName,
        this.rentRoom,
        this.bedroom,
        this.tv,
        this.roomHeater,
        this.toilet,
        this.hotDrinking,
        this.noOfRoom,
        this.description,
        this.propertyImage,
        this.accountName,
        this.accountNumber,
        this.bankName,
        this.ifscCode,
        this.cancelChaque,
        this.createdAt,
        this.status,
        this.propertyId,
        this.creatDate,
        this.name,
        this.cityCode,
        this.stateId,this.rating});

  EcoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    cityId = json['city_id'].toString();
    catId = json['cat_id'].toString();
    hostId = json['host_id'].toString();
    title = json['title'].toString();
    contactName = json['contact_name'].toString();
    contact = json['contact'].toString();
    email = json['email'].toString();
    address = json['address'].toString();
    type = json['type'].toString();
    typeName = json['type_name'].toString();
    checkIn = json['check_in'].toString();
    checkOut = json['check_out'].toString();
    internet = json['internet'].toString();
    others = json['others'].toString();
    roomType = json['room_type'].toString();
    roomTypeName = json['room_type_name'].toString();
    rentRoom = json['rent_room'].toString();
    bedroom = json['bedroom'].toString();
    tv = json['tv'].toString();
    roomHeater = json['room_heater'].toString();
    toilet = json['toilet'].toString();
    hotDrinking = json['hot_drinking'].toString();
    noOfRoom = json['no_of_room'].toString();
    description = json['description'].toString();
    propertyImage = json['property_image'].toString();
    accountName = json['account_name'].toString();
    accountNumber = json['account_number'].toString();
    bankName = json['bank_name'].toString();
    ifscCode = json['ifsc_code'].toString();
    cancelChaque = json['cancel_chaque'].toString();
    createdAt = json['created_at'].toString();
    status = json['status'].toString();
    propertyId = json['property_id'].toString();
    creatDate = json['creat_date'].toString();
    name = json['name'].toString();
    cityCode = json['city_code'].toString();
    stateId = json['state_id'].toString();
    rating = json['rating'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['cat_id'] = this.catId;
    data['host_id'] = this.hostId;
    data['title'] = this.title;
    data['contact_name'] = this.contactName;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['address'] = this.address;
    data['type'] = this.type;
    data['type_name'] = this.typeName;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['internet'] = this.internet;
    data['others'] = this.others;
    data['room_type'] = this.roomType;
    data['room_type_name'] = this.roomTypeName;
    data['rent_room'] = this.rentRoom;
    data['bedroom'] = this.bedroom;
    data['tv'] = this.tv;
    data['room_heater'] = this.roomHeater;
    data['toilet'] = this.toilet;
    data['hot_drinking'] = this.hotDrinking;
    data['no_of_room'] = this.noOfRoom;
    data['description'] = this.description;
    data['property_image'] = this.propertyImage;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['cancel_chaque'] = this.cancelChaque;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['property_id'] = this.propertyId;
    data['creat_date'] = this.creatDate;
    data['name'] = this.name;
    data['city_code'] = this.cityCode;
    data['state_id'] = this.stateId;
    return data;
  }
}