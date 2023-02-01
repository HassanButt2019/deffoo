class GetProfileResponse {
  bool? status;
  String? message;
  List<Profile>? profile;
  String? imgPath;

  GetProfileResponse({this.status, this.message, this.profile, this.imgPath});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['profile'] != null) {
      profile = <Profile>[];
      json['profile'].forEach((v) {
        profile!.add(new Profile.fromJson(v));
      });
    }
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.profile != null) {
      data['profile'] = this.profile!.map((v) => v.toJson()).toList();
    }
    data['img_path'] = this.imgPath;
    return data;
  }
}

class Profile {
  String? userId;
  String? userPhone;
  String? firstname;
  String? userEmail;
  String? address;
  String? userImage;

  Profile({
    this.userId,
    this.userPhone,
    this.firstname,
    this.userEmail,
    this.userImage,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userPhone = json['user_phone'];
    firstname = json['firstname']!=null?json['firstname']:json['user_name'];
    userEmail = json['user_email'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_phone'] = this.userPhone;
    data['firstname'] = this.firstname;
    data['user_email'] = this.userEmail;
    data['user_image'] = this.userImage;

    return data;
  }
}
