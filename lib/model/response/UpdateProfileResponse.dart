import 'dart:convert';
/// status : true
/// message : "updated profile successfully"
/// data : {"user_id":"163","restro_id":"0","user_phone":"7049202363","firstname":"Deepak Minj","lastname":"","user_fullname":"","user_email":"","gender":"","user_bdate":"","user_password":"","user_city":"","address":"","varification_code":"","user_image":"","pincode":"0","socity_id":"","house_no":"","mobile_verified":"0","user_gcm_code":"as","user_ios_token":"","varified_token":"","status":"0","reg_code":"0","wallet":"0","rewards":"0","created":"","modified":"","otp":"6672","otp_status":"0","social":"","firebaseToken":"","country_code":"","area_code":"","user_type":"0","driving_licence_no":"","radius":"0","vehicle_type":"","vehicle_no":"","login_status":"0","driving_licence_photo":"","is_avaible":"0"}

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));
String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());
class UpdateProfileResponse {
  UpdateProfileResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UpdateProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  //  _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// user_id : "163"
/// restro_id : "0"
/// user_phone : "7049202363"
/// firstname : "Deepak Minj"
/// lastname : ""
/// user_fullname : ""
/// user_email : ""
/// gender : ""
/// user_bdate : ""
/// user_password : ""
/// user_city : ""
/// address : ""
/// varification_code : ""
/// user_image : ""
/// pincode : "0"
/// socity_id : ""
/// house_no : ""
/// mobile_verified : "0"
/// user_gcm_code : "as"
/// user_ios_token : ""
/// varified_token : ""
/// status : "0"
/// reg_code : "0"
/// wallet : "0"
/// rewards : "0"
/// created : ""
/// modified : ""
/// otp : "6672"
/// otp_status : "0"
/// social : ""
/// firebaseToken : ""
/// country_code : ""
/// area_code : ""
/// user_type : "0"
/// driving_licence_no : ""
/// radius : "0"
/// vehicle_type : ""
/// vehicle_no : ""
/// login_status : "0"
/// driving_licence_photo : ""
/// is_avaible : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? userId, 
      String? restroId, 
      String? userPhone, 
      String? firstname, 
      String? lastname, 
      String? userFullname, 
      String? userEmail, 
      String? gender, 
      String? userBdate, 
      String? userPassword, 
      String? userCity, 
      String? address, 
      String? varificationCode, 
      String? userImage, 
      String? pincode, 
      String? socityId, 
      String? houseNo, 
      String? mobileVerified, 
      String? userGcmCode, 
      String? userIosToken, 
      String? varifiedToken, 
      String? status, 
      String? regCode, 
      String? wallet, 
      String? rewards, 
      String? created, 
      String? modified, 
      String? otp, 
      String? otpStatus, 
      String? social, 
      String? firebaseToken, 
      String? countryCode, 
      String? areaCode, 
      String? userType, 
      String? drivingLicenceNo, 
      String? radius, 
      String? vehicleType, 
      String? vehicleNo, 
      String? loginStatus, 
      String? drivingLicencePhoto, 
      String? isAvaible,}){
    _userId = userId;
    _restroId = restroId;
    _userPhone = userPhone;
    _firstname = firstname;
    _lastname = lastname;
    _userFullname = userFullname;
    _userEmail = userEmail;
    _gender = gender;
    _userBdate = userBdate;
    _userPassword = userPassword;
    _userCity = userCity;
    _address = address;
    _varificationCode = varificationCode;
    _userImage = userImage;
    _pincode = pincode;
    _socityId = socityId;
    _houseNo = houseNo;
    _mobileVerified = mobileVerified;
    _userGcmCode = userGcmCode;
    _userIosToken = userIosToken;
    _varifiedToken = varifiedToken;
    _status = status;
    _regCode = regCode;
    _wallet = wallet;
    _rewards = rewards;
    _created = created;
    _modified = modified;
    _otp = otp;
    _otpStatus = otpStatus;
    _social = social;
    _firebaseToken = firebaseToken;
    _countryCode = countryCode;
    _areaCode = areaCode;
    _userType = userType;
    _drivingLicenceNo = drivingLicenceNo;
    _radius = radius;
    _vehicleType = vehicleType;
    _vehicleNo = vehicleNo;
    _loginStatus = loginStatus;
    _drivingLicencePhoto = drivingLicencePhoto;
    _isAvaible = isAvaible;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _restroId = json['restro_id'];
    _userPhone = json['user_phone'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _userFullname = json['user_fullname'];
    _userEmail = json['user_email'];
    _gender = json['gender'];
    _userBdate = json['user_bdate'];
    _userPassword = json['user_password'];
    _userCity = json['user_city'];
    _address = json['address'];
    _varificationCode = json['varification_code'];
    _userImage = json['user_image'];
    _pincode = json['pincode'];
    _socityId = json['socity_id'];
    _houseNo = json['house_no'];
    _mobileVerified = json['mobile_verified'];
    _userGcmCode = json['user_gcm_code'];
    _userIosToken = json['user_ios_token'];
    _varifiedToken = json['varified_token'];
    _status = json['status'];
    _regCode = json['reg_code'];
    _wallet = json['wallet'];
    _rewards = json['rewards'];
    _created = json['created'];
    _modified = json['modified'];
    _otp = json['otp'];
    _otpStatus = json['otp_status'];
    _social = json['social'];
    _firebaseToken = json['firebaseToken'];
    _countryCode = json['country_code'];
    _areaCode = json['area_code'];
    _userType = json['user_type'];
    _drivingLicenceNo = json['driving_licence_no'];
    _radius = json['radius'];
    _vehicleType = json['vehicle_type'];
    _vehicleNo = json['vehicle_no'];
    _loginStatus = json['login_status'];
    _drivingLicencePhoto = json['driving_licence_photo'];
    _isAvaible = json['is_avaible'];
  }
  String? _userId;
  String? _restroId;
  String? _userPhone;
  String? _firstname;
  String? _lastname;
  String? _userFullname;
  String? _userEmail;
  String? _gender;
  String? _userBdate;
  String? _userPassword;
  String? _userCity;
  String? _address;
  String? _varificationCode;
  String? _userImage;
  String? _pincode;
  String? _socityId;
  String? _houseNo;
  String? _mobileVerified;
  String? _userGcmCode;
  String? _userIosToken;
  String? _varifiedToken;
  String? _status;
  String? _regCode;
  String? _wallet;
  String? _rewards;
  String? _created;
  String? _modified;
  String? _otp;
  String? _otpStatus;
  String? _social;
  String? _firebaseToken;
  String? _countryCode;
  String? _areaCode;
  String? _userType;
  String? _drivingLicenceNo;
  String? _radius;
  String? _vehicleType;
  String? _vehicleNo;
  String? _loginStatus;
  String? _drivingLicencePhoto;
  String? _isAvaible;

  String? get userId => _userId;
  String? get restroId => _restroId;
  String? get userPhone => _userPhone;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get userFullname => _userFullname;
  String? get userEmail => _userEmail;
  String? get gender => _gender;
  String? get userBdate => _userBdate;
  String? get userPassword => _userPassword;
  String? get userCity => _userCity;
  String? get address => _address;
  String? get varificationCode => _varificationCode;
  String? get userImage => _userImage;
  String? get pincode => _pincode;
  String? get socityId => _socityId;
  String? get houseNo => _houseNo;
  String? get mobileVerified => _mobileVerified;
  String? get userGcmCode => _userGcmCode;
  String? get userIosToken => _userIosToken;
  String? get varifiedToken => _varifiedToken;
  String? get status => _status;
  String? get regCode => _regCode;
  String? get wallet => _wallet;
  String? get rewards => _rewards;
  String? get created => _created;
  String? get modified => _modified;
  String? get otp => _otp;
  String? get otpStatus => _otpStatus;
  String? get social => _social;
  String? get firebaseToken => _firebaseToken;
  String? get countryCode => _countryCode;
  String? get areaCode => _areaCode;
  String? get userType => _userType;
  String? get drivingLicenceNo => _drivingLicenceNo;
  String? get radius => _radius;
  String? get vehicleType => _vehicleType;
  String? get vehicleNo => _vehicleNo;
  String? get loginStatus => _loginStatus;
  String? get drivingLicencePhoto => _drivingLicencePhoto;
  String? get isAvaible => _isAvaible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['restro_id'] = _restroId;
    map['user_phone'] = _userPhone;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['user_fullname'] = _userFullname;
    map['user_email'] = _userEmail;
    map['gender'] = _gender;
    map['user_bdate'] = _userBdate;
    map['user_password'] = _userPassword;
    map['user_city'] = _userCity;
    map['address'] = _address;
    map['varification_code'] = _varificationCode;
    map['user_image'] = _userImage;
    map['pincode'] = _pincode;
    map['socity_id'] = _socityId;
    map['house_no'] = _houseNo;
    map['mobile_verified'] = _mobileVerified;
    map['user_gcm_code'] = _userGcmCode;
    map['user_ios_token'] = _userIosToken;
    map['varified_token'] = _varifiedToken;
    map['status'] = _status;
    map['reg_code'] = _regCode;
    map['wallet'] = _wallet;
    map['rewards'] = _rewards;
    map['created'] = _created;
    map['modified'] = _modified;
    map['otp'] = _otp;
    map['otp_status'] = _otpStatus;
    map['social'] = _social;
    map['firebaseToken'] = _firebaseToken;
    map['country_code'] = _countryCode;
    map['area_code'] = _areaCode;
    map['user_type'] = _userType;
    map['driving_licence_no'] = _drivingLicenceNo;
    map['radius'] = _radius;
    map['vehicle_type'] = _vehicleType;
    map['vehicle_no'] = _vehicleNo;
    map['login_status'] = _loginStatus;
    map['driving_licence_photo'] = _drivingLicencePhoto;
    map['is_avaible'] = _isAvaible;
    return map;
  }

}