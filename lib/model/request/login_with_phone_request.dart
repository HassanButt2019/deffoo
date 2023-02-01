class LoginRequest {
  String phone;
  String firebaseToken;

  LoginRequest({required this.phone, required this.firebaseToken});

  Map<String, dynamic> tojson() =>
      {'user_phone': this.phone, 'firebaseToken': this.firebaseToken};
}
