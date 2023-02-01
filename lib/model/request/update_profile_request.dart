class UpdateProfileRequest {
  String userId;
  String firstname;
  String userEmail;

  UpdateProfileRequest(this.userId, this.firstname, this.userEmail);

  Map<String, dynamic> tojson() => {
    'user_id': this.userId,
    "firstname": this.firstname,
    "user_email": this.userEmail
  };
}