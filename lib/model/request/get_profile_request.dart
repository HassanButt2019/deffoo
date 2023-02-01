class GetProfileRequest {
  String userId;

  GetProfileRequest({required this.userId});

  Map<String, dynamic> tojson() => {'user_id': this.userId};
}
