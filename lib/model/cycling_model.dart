class CyclingModel {
  String? id;
  String? hostId;
  String? userId;
  String? cycleId;
  String? cycleName;
  String? bikeId;
  String? bikeName;
  String? customerName;
  String? phone;
  String? email;
  String? date;
  String? noOfGuest;
  String? amount;
  String? payment;
  String? createDate;
  String? status;
  String? confirmCancel;
  String? completeBooking;
  String? userName;
  String? firstname;
  String? lastname;
  String? userEmail;
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

  String? accountName;

  String? image;

  CyclingModel(
      {this.id,
        this.hostId,
        this.userId,
        this.cycleId,
        this.cycleName,
        this.bikeId,
        this.bikeName,
        this.customerName,
        this.phone,
        this.email,
        this.date,
        this.noOfGuest,
        this.amount,
        this.payment,
        this.createDate,
        this.status,
        this.confirmCancel,
        this.completeBooking,
        this.userName,
        this.firstname,
        this.lastname,
        this.userEmail,
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

        this.accountName,

        this.image});

  CyclingModel.fromJson(Map<String, dynamic> json) {
    id = json['booking_id'];
    hostId = json['host_id'];
    userId = json['user_id'];
    cycleId = json['cycle_id'];
    cycleName = json['cycle_name'];
    bikeId = json['bike_id'];
    bikeName = json['bike_name'];
    customerName = json['customer_name'];
    phone = json['phone'];
    email = json['email'];
    date = json['date'];
    noOfGuest = json['no_of_guest'];
    amount = json['amount'];
    payment = json['payment'];
    createDate = json['create_date'];
    status = json['status'];
    confirmCancel = json['confirm_cancel'];
    completeBooking = json['complte_booking'];
    userName = json['user_name'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    userEmail = json['user_email'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['host_id'] = this.hostId;
    data['user_id'] = this.userId;
    data['cycle_id'] = this.cycleId;
    data['cycle_name'] = this.cycleName;
    data['bike_id'] = this.bikeId;
    data['bike_name'] = this.bikeName;
    data['customer_name'] = this.customerName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['date'] = this.date;
    data['no_of_guest'] = this.noOfGuest;
    data['amount'] = this.amount;
    data['payment'] = this.payment;
    data['create_date'] = this.createDate;
    data['status'] = this.status;
    data['confirm_cancel'] = this.confirmCancel;
    data['complte_booking'] = this.completeBooking;
    data['user_name'] = this.userName;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['user_email'] = this.userEmail;
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
    return data;
  }
}
