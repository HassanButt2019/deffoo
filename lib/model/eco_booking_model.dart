class EcoBookingModel1 {
  String? id;
  String? propertyId;
  String? hostId;
  String? userId;
  String? userName;
  String? userContact;
  String? userEmail;
  String? checkIn;
  String? checkOut;
  String? checkInTime;
  String? checkOutTime;
  String? noOfGuest;
  String? noOfRoom;
  String? roomId;
  String? amount;
  String? payment;
  String? status;
  String? createDate;
  String? firstname;
  String? lastname;
  String? gender;
  String? userPhone;
  String? userFullname;
  String? userPassword;
  String? idCardName;
  String? panCardNumber;
  String? userTypeId;
  Null? userBdate;
  String? numberOfTable;
  String? isEmailVarified;
  String? varifiedToken;
  String? varificationCode;
  String? userGcmCode;
  String? userIosToken;
  String? userImage;
  String? userCity;
  String? userState;
  String? pincode;
  String? latitude;
  String? longnitute;
  String? overview;
  String? location;
  String? idProof;
  String? state;
  String? streetAddress;
  String? userLoginStatus;
  String? userStatus;
  String? roleStatus;
  String? bankAcoountHolderName;
  String? bankName;
  String? accountNo;
  String? ifscCode;
  String? tablePerAmount;
  String? aaddharNo;
  String? aaddharPhoto;
  String? otp;
  String? mode;
  String? password;
  String? createdAt;
  String? cityId;
  String? catId;
  String? title;
  String? contactName;
  String? contact;
  String? email;
  String? address;
  String? type;
  String? typeName;
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
  String? description;
  String? propertyImage;
  String? accountName;
  String? accountNumber;
  String? cancelChaque;
  String? creatDate;

  EcoBookingModel1(
      {this.id,
        this.propertyId,
        this.hostId,
        this.userId,
        this.userName,
        this.userContact,
        this.userEmail,
        this.checkIn,
        this.checkOut,
        this.checkInTime,
        this.checkOutTime,
        this.noOfGuest,
        this.noOfRoom,
        this.roomId,
        this.amount,
        this.payment,
        this.status,
        this.createDate,
        this.firstname,
        this.lastname,
        this.gender,
        this.userPhone,
        this.userFullname,
        this.userPassword,
        this.idCardName,
        this.panCardNumber,
        this.userTypeId,
        this.userBdate,
        this.numberOfTable,
        this.isEmailVarified,
        this.varifiedToken,
        this.varificationCode,
        this.userGcmCode,
        this.userIosToken,
        this.userImage,
        this.userCity,
        this.userState,
        this.pincode,
        this.latitude,
        this.longnitute,
        this.overview,
        this.location,
        this.idProof,
        this.state,
        this.streetAddress,
        this.userLoginStatus,
        this.userStatus,
        this.roleStatus,
        this.bankAcoountHolderName,
        this.bankName,
        this.accountNo,
        this.ifscCode,
        this.tablePerAmount,
        this.aaddharNo,
        this.aaddharPhoto,
        this.otp,
        this.mode,
        this.password,
        this.createdAt,
        this.cityId,
        this.catId,
        this.title,
        this.contactName,
        this.contact,
        this.email,
        this.address,
        this.type,
        this.typeName,
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
        this.description,
        this.propertyImage,
        this.accountName,
        this.accountNumber,
        this.cancelChaque,
        this.creatDate});

  EcoBookingModel1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    hostId = json['host_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userContact = json['user_contact'];
    userEmail = json['user_email'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    noOfGuest = json['no_of_guest'];
    noOfRoom = json['no_of_room'];
    roomId = json['room_id'];
    amount = json['amount'];
    payment = json['payment'];
    status = json['status'];
    createDate = json['create_date'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    userPhone = json['user_phone'];
    userFullname = json['user_fullname'];
    userPassword = json['user_password'];
    idCardName = json['id_card_name'];
    panCardNumber = json['pan_card_number'];
    userTypeId = json['user_type_id'];
    userBdate = json['user_bdate'];
    numberOfTable = json['number_of_table'];
    isEmailVarified = json['is_email_varified'];
    varifiedToken = json['varified_token'];
    varificationCode = json['varification_code'];
    userGcmCode = json['user_gcm_code'];
    userIosToken = json['user_ios_token'];
    userImage = json['user_image'];
    userCity = json['user_city'];
    userState = json['user_state'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longnitute = json['longnitute'];
    overview = json['overview'];
    location = json['location'];
    idProof = json['id_proof'];
    state = json['state'];
    streetAddress = json['street_address'];
    userLoginStatus = json['user_login_status'];
    userStatus = json['user_status'];
    roleStatus = json['role_status'];
    bankAcoountHolderName = json['bankAcoountHolderName'];
    bankName = json['bankName'];
    accountNo = json['accountNo'];
    ifscCode = json['ifscCode'];
    tablePerAmount = json['table_per_amount'];
    aaddharNo = json['aaddhar_no'];
    aaddharPhoto = json['aaddhar_photo'];
    otp = json['otp'];
    mode = json['mode'];
    password = json['password'];
    createdAt = json['created_at'];
    cityId = json['city_id'];
    catId = json['cat_id'];
    title = json['title'];
    contactName = json['contact_name'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
    type = json['type'];
    typeName = json['type_name'];
    internet = json['internet'];
    others = json['others'];
    roomType = json['room_type'];
    roomTypeName = json['room_type_name'];
    rentRoom = json['rent_room'];
    bedroom = json['bedroom'];
    tv = json['tv'];
    roomHeater = json['room_heater'];
    toilet = json['toilet'];
    hotDrinking = json['hot_drinking'];
    description = json['description'];
    propertyImage = json['property_image'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    cancelChaque = json['cancel_chaque'];
    creatDate = json['creat_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['host_id'] = this.hostId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_contact'] = this.userContact;
    data['user_email'] = this.userEmail;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    data['no_of_guest'] = this.noOfGuest;
    data['no_of_room'] = this.noOfRoom;
    data['room_id'] = this.roomId;
    data['amount'] = this.amount;
    data['payment'] = this.payment;
    data['status'] = this.status;
    data['create_date'] = this.createDate;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['user_phone'] = this.userPhone;
    data['user_fullname'] = this.userFullname;
    data['user_password'] = this.userPassword;
    data['id_card_name'] = this.idCardName;
    data['pan_card_number'] = this.panCardNumber;
    data['user_type_id'] = this.userTypeId;
    data['user_bdate'] = this.userBdate;
    data['number_of_table'] = this.numberOfTable;
    data['is_email_varified'] = this.isEmailVarified;
    data['varified_token'] = this.varifiedToken;
    data['varification_code'] = this.varificationCode;
    data['user_gcm_code'] = this.userGcmCode;
    data['user_ios_token'] = this.userIosToken;
    data['user_image'] = this.userImage;
    data['user_city'] = this.userCity;
    data['user_state'] = this.userState;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longnitute'] = this.longnitute;
    data['overview'] = this.overview;
    data['location'] = this.location;
    data['id_proof'] = this.idProof;
    data['state'] = this.state;
    data['street_address'] = this.streetAddress;
    data['user_login_status'] = this.userLoginStatus;
    data['user_status'] = this.userStatus;
    data['role_status'] = this.roleStatus;
    data['bankAcoountHolderName'] = this.bankAcoountHolderName;
    data['bankName'] = this.bankName;
    data['accountNo'] = this.accountNo;
    data['ifscCode'] = this.ifscCode;
    data['table_per_amount'] = this.tablePerAmount;
    data['aaddhar_no'] = this.aaddharNo;
    data['aaddhar_photo'] = this.aaddharPhoto;
    data['otp'] = this.otp;
    data['mode'] = this.mode;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['city_id'] = this.cityId;
    data['cat_id'] = this.catId;
    data['title'] = this.title;
    data['contact_name'] = this.contactName;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['address'] = this.address;
    data['type'] = this.type;
    data['type_name'] = this.typeName;
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
    data['description'] = this.description;
    data['property_image'] = this.propertyImage;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['cancel_chaque'] = this.cancelChaque;
    data['creat_date'] = this.creatDate;
    return data;
  }
}
class EcoBookingModel {
  String? id;
  String? propertyId;
  String? hostId;
  String? userId;
  String? userName;
  String? userContact;
  String? userEmail;
  String? checkIn;
  String? checkOut;
  String? checkInTime;
  String? checkOutTime;
  String? noOfGuest;
  String? noOfRoom;
  String? roomId;
  String? amount;
  String? payment;
  String? status;
  String? complteBooking;
  String? confirmCancel;
  String? createDate;
  String? firstname;
  String? lastname;
  String? gender;
  String? userPhone;
  String? userFullname;
  String? userPassword;
  String? idCardName;
  String? panCardNumber;
  String? userTypeId;
  Null? userBdate;
  String? numberOfTable;
  String? isEmailVarified;
  String? varifiedToken;
  String? varificationCode;
  String? userGcmCode;
  String? userIosToken;
  String? userImage;
  String? userCity;
  String? userState;
  String? pincode;
  String? latitude;
  String? longnitute;
  String? overview;
  String? location;
  String? idProof;
  String? state;
  String? streetAddress;
  String? userLoginStatus;
  String? userStatus;
  String? roleStatus;
  String? bankAcoountHolderName;
  String? bankName;
  String? accountNo;
  String? ifscCode;
  String? tablePerAmount;
  String? aaddharNo;
  String? aaddharPhoto;
  String? otp;
  String? mode;
  String? password;
  String? createdAt;
  String? cityId;
  String? catId;
  String? title;
  String? contactName;
  String? contact;
  String? email;
  String? address;
  String? type;
  String? typeName;
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
  String? description;
  String? propertyImage;
  String? accountName;
  String? accountNumber;
  String? cancelChaque;
  String? creatDate;
  String? checkInDate;
  String? checkOutDate;
  EcoBookingModel(
      {this.id,
        this.propertyId,
        this.hostId,
        this.userId,
        this.userName,
        this.userContact,
        this.userEmail,
        this.checkIn,
        this.checkOut,
        this.checkInTime,
        this.checkOutTime,
        this.noOfGuest,
        this.noOfRoom,
        this.roomId,
        this.amount,
        this.payment,
        this.status,
        this.complteBooking,
        this.confirmCancel,
        this.createDate,
        this.firstname,
        this.lastname,
        this.gender,
        this.userPhone,
        this.userFullname,
        this.userPassword,
        this.idCardName,
        this.panCardNumber,
        this.userTypeId,
        this.userBdate,
        this.numberOfTable,
        this.isEmailVarified,
        this.varifiedToken,
        this.varificationCode,
        this.userGcmCode,
        this.userIosToken,
        this.userImage,
        this.userCity,
        this.userState,
        this.pincode,
        this.latitude,
        this.longnitute,
        this.overview,
        this.location,
        this.idProof,
        this.state,
        this.streetAddress,
        this.userLoginStatus,
        this.userStatus,
        this.roleStatus,
        this.bankAcoountHolderName,
        this.bankName,
        this.accountNo,
        this.ifscCode,
        this.tablePerAmount,
        this.aaddharNo,
        this.aaddharPhoto,
        this.otp,
        this.mode,
        this.password,
        this.createdAt,
        this.cityId,
        this.catId,
        this.title,
        this.contactName,
        this.contact,
        this.email,
        this.address,
        this.type,
        this.typeName,
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
        this.description,
        this.propertyImage,
        this.accountName,
        this.accountNumber,
        this.cancelChaque,
        this.creatDate,
        this.checkInDate,
        this.checkOutDate});

  EcoBookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    hostId = json['host_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userContact = json['user_contact'];
    userEmail = json['user_email'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    noOfGuest = json['no_of_guest'];
    noOfRoom = json['no_of_room'];
    roomId = json['room_id'];
    amount = json['amount'];
    payment = json['payment'];
    status = json['status'];
    complteBooking = json['complte_booking'];
    confirmCancel = json['confirm_cancel'];
    createDate = json['create_date'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    userPhone = json['user_phone'];
    userFullname = json['user_fullname'];
    userPassword = json['user_password'];
    idCardName = json['id_card_name'];
    panCardNumber = json['pan_card_number'];
    userTypeId = json['user_type_id'];
    userBdate = json['user_bdate'];
    numberOfTable = json['number_of_table'];
    isEmailVarified = json['is_email_varified'];
    varifiedToken = json['varified_token'];
    varificationCode = json['varification_code'];
    userGcmCode = json['user_gcm_code'];
    userIosToken = json['user_ios_token'];
    userImage = json['user_image'];
    userCity = json['user_city'];
    userState = json['user_state'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longnitute = json['longnitute'];
    overview = json['overview'];
    location = json['location'];
    idProof = json['id_proof'];
    state = json['state'];
    streetAddress = json['street_address'];
    userLoginStatus = json['user_login_status'];
    userStatus = json['user_status'];
    roleStatus = json['role_status'];
    bankAcoountHolderName = json['bankAcoountHolderName'];
    bankName = json['bankName'];
    accountNo = json['accountNo'];
    ifscCode = json['ifscCode'];
    tablePerAmount = json['table_per_amount'];
    aaddharNo = json['aaddhar_no'];
    aaddharPhoto = json['aaddhar_photo'];
    otp = json['otp'];
    mode = json['mode'];
    password = json['password'];
    createdAt = json['created_at'];
    cityId = json['city_id'];
    catId = json['cat_id'];
    title = json['title'];
    contactName = json['contact_name'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
    type = json['type'];
    typeName = json['type_name'];
    internet = json['internet'];
    others = json['others'];
    roomType = json['room_type'];
    roomTypeName = json['room_type_name'];
    rentRoom = json['rent_room'];
    bedroom = json['bedroom'];
    tv = json['tv'];
    roomHeater = json['room_heater'];
    toilet = json['toilet'];
    hotDrinking = json['hot_drinking'];
    description = json['description'];
    propertyImage = json['property_image'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    cancelChaque = json['cancel_chaque'];
    creatDate = json['creat_date'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['host_id'] = this.hostId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_contact'] = this.userContact;
    data['user_email'] = this.userEmail;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    data['no_of_guest'] = this.noOfGuest;
    data['no_of_room'] = this.noOfRoom;
    data['room_id'] = this.roomId;
    data['amount'] = this.amount;
    data['payment'] = this.payment;
    data['status'] = this.status;
    data['complte_booking'] = this.complteBooking;
    data['confirm_cancel'] = this.confirmCancel;
    data['create_date'] = this.createDate;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['user_phone'] = this.userPhone;
    data['user_fullname'] = this.userFullname;
    data['user_password'] = this.userPassword;
    data['id_card_name'] = this.idCardName;
    data['pan_card_number'] = this.panCardNumber;
    data['user_type_id'] = this.userTypeId;
    data['user_bdate'] = this.userBdate;
    data['number_of_table'] = this.numberOfTable;
    data['is_email_varified'] = this.isEmailVarified;
    data['varified_token'] = this.varifiedToken;
    data['varification_code'] = this.varificationCode;
    data['user_gcm_code'] = this.userGcmCode;
    data['user_ios_token'] = this.userIosToken;
    data['user_image'] = this.userImage;
    data['user_city'] = this.userCity;
    data['user_state'] = this.userState;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longnitute'] = this.longnitute;
    data['overview'] = this.overview;
    data['location'] = this.location;
    data['id_proof'] = this.idProof;
    data['state'] = this.state;
    data['street_address'] = this.streetAddress;
    data['user_login_status'] = this.userLoginStatus;
    data['user_status'] = this.userStatus;
    data['role_status'] = this.roleStatus;
    data['bankAcoountHolderName'] = this.bankAcoountHolderName;
    data['bankName'] = this.bankName;
    data['accountNo'] = this.accountNo;
    data['ifscCode'] = this.ifscCode;
    data['table_per_amount'] = this.tablePerAmount;
    data['aaddhar_no'] = this.aaddharNo;
    data['aaddhar_photo'] = this.aaddharPhoto;
    data['otp'] = this.otp;
    data['mode'] = this.mode;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['city_id'] = this.cityId;
    data['cat_id'] = this.catId;
    data['title'] = this.title;
    data['contact_name'] = this.contactName;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['address'] = this.address;
    data['type'] = this.type;
    data['type_name'] = this.typeName;
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
    data['description'] = this.description;
    data['property_image'] = this.propertyImage;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['cancel_chaque'] = this.cancelChaque;
    data['creat_date'] = this.creatDate;
    data['check_in_date'] = this.checkInDate;
    data['check_out_date'] = this.checkOutDate;
    return data;
  }
}