class BookingModel{
  String   id,
  host_id,
  user_id,
  hotel_cat,
  hotel_sub_cat,
  hotel_cat_id,

  hotel_sub_cat_id,
  check_in,
  check_out,

  check_in_time,
  check_out_time,
  no_of_guest,

  amount,
  payment,
  status,
  create_date;

  BookingModel(
      this.id,
      this.host_id,
      this.user_id,
      this.hotel_cat,
      this.hotel_sub_cat,
      this.hotel_cat_id,
      this.hotel_sub_cat_id,
      this.check_in,
      this.check_out,
      this.check_in_time,
      this.check_out_time,
      this.no_of_guest,
      this.amount,
      this.payment,
      this.status,
      this.create_date);
}

class MessageModel {
  int? senderId;
  int? receiverId;
  String? msg;
  String? time;

  MessageModel({this.senderId, this.receiverId, this.msg, this.time});
}
