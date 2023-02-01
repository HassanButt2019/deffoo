class LoginResponse {
  bool? status;
  String? errorCode;
  String? message;
  String? otp;
  String? userId;

  LoginResponse(
      {this.status, this.errorCode, this.message, this.otp, this.userId});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['error_code'].toString();
    message = json['message'].toString();
    otp = json['otp'].toString();
    userId = json['user_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error_code'] = this.errorCode.toString();
    data['message'] = this.message.toString();
    data['otp'] = this.otp.toString();
    data['user_id'] = this.userId.toString();
    return data;
  }
}
