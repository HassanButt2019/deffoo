class ResendOtpResponse {
  bool? status;
  String? message;
  int? otp;
  String? phoneNumber;
  String? userId;

  ResendOtpResponse(
      {this.status, this.message, this.otp, this.phoneNumber, this.userId});

  ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otp = json['otp'];
    phoneNumber = json['phone_number'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['otp'] = this.otp;
    data['phone_number'] = this.phoneNumber;
    data['user_id'] = this.userId;
    return data;
  }
}
