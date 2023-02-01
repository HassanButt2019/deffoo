class RatingModel {
  String? id;
  String? typeId;
  String? propertyId;
  String? userId;
  String? rating;
  String? comment;
  String? approved;
  String? time;
  String? firstname;
  String? userImage;
  String? userName;

  RatingModel(
      {this.id,
        this.typeId,
        this.propertyId,
        this.userId,
        this.rating,
        this.comment,
        this.approved,
        this.time,
        this.firstname,
        this.userImage,
        this.userName});

  RatingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    propertyId = json['property_id'];
    userId = json['user_id'];
    rating = json['rating'].toString();
    comment = json['comment'];
    approved = json['approved'];
    time = json['time'];
    firstname = json['firstname'];
    userImage = json['user_image'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['property_id'] = this.propertyId;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['approved'] = this.approved;
    data['time'] = this.time;
    data['firstname'] = this.firstname;
    data['user_image'] = this.userImage;
    data['user_name'] = this.userName;
    return data;
  }
}
