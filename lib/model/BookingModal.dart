import 'dart:convert';
/// status : true
/// meassge : " Hotel Booking successfully"

BookingModal bookingModalFromJson(String str) => BookingModal.fromJson(json.decode(str));
String bookingModalToJson(BookingModal data) => json.encode(data.toJson());
class BookingModal {
  BookingModal({
    bool? status,
    String? meassge,}){
    _status = status;
    _meassge = meassge;
  }

  BookingModal.fromJson(dynamic json) {
    _status = json['status'];
    _meassge = json['meassge'];
  }
  bool? _status;
  String? _meassge;
  BookingModal copyWith({  bool? status,
    String? meassge,
  }) => BookingModal(  status: status ?? _status,
    meassge: meassge ?? _meassge,
  );
  bool? get status => _status;
  String? get meassge => _meassge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['meassge'] = _meassge;
    return map;
  }

}