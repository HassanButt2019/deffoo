class ResendOtpRequest {
  String phone;

  ResendOtpRequest({required this.phone});

  Map<String, dynamic> tojson() => {'user_phone': this.phone};
}
