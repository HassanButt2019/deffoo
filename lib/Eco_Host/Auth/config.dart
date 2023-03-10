import 'package:deffo/Eco_Host/Auth/booking_model.dart';
import 'package:flutter/material.dart';

String? validateField(String value, String? msg) {
  if (value.length == 0)
    return msg;
  else
    return null;
}

String? validateEmail(String value, String? msg1, String? msg2) {
  if (value.length == 0) {
    return msg1;
  } else if (!RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
      r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
      r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
      .hasMatch(value)) {
    return msg2;
  } else {
    return null;
  }
}
String? validateMob(String value, String? msg1, String? msg2) {
  if (value.isEmpty) {
    return msg1;
  }
  if (value.length !=10) {
    return msg2;
  }
  return null;
}
setSnackbar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content:Text(
      msg,
    ),
    behavior: SnackBarBehavior.floating,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Colors.black,
    elevation: 1.0,
  ));
}
const Sender_id = 1;
const Receiver_id = 2;
void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());
List<MessageModel> getChatMsgData() {
  List<MessageModel> list = [];

  MessageModel c1 = MessageModel();
  c1.senderId = Sender_id;
  c1.receiverId = Receiver_id;
  c1.msg = 'Helloo';
  c1.time = '1:43 AM';
  list.add(c1);

  MessageModel c2 = MessageModel();
  c2.senderId = Sender_id;
  c2.receiverId = Receiver_id;
  c2.msg = 'How are you? What are you doing?';
  c2.time = '1:45 AM';
  list.add(c2);

  MessageModel c3 = MessageModel();
  c3.senderId = Receiver_id;
  c3.receiverId = Sender_id;
  c3.msg = 'Helloo...';
  c3.time = '1:45 AM';
  list.add(c3);

  MessageModel c4 = MessageModel();
  c4.senderId = Sender_id;
  c4.receiverId = Receiver_id;
  c4.msg = 'I am good. Can you do something for me? I need your help.';
  c4.time = '1:45 AM';
  list.add(c4);

  MessageModel c5 = MessageModel();
  c5.senderId = Sender_id;
  c5.receiverId = Receiver_id;
  c5.msg = 'I am good. Can you do something for me? I need your help.';
  c5.time = '1:45 AM';
  list.add(c5);

  MessageModel c6 = MessageModel();
  c6.senderId = Receiver_id;
  c6.receiverId = Sender_id;
  c6.msg = 'I am good. Can you do something for me? I need your help.';
  c6.time = '1:45 AM';
  list.add(c6);

  MessageModel c7 = MessageModel();
  c7.senderId = Sender_id;
  c7.receiverId = Receiver_id;
  c7.msg = 'I am good. Can you do something for me? I need your help.';
  c7.time = '1:45 AM';
  list.add(c7);

  MessageModel c8 = MessageModel();
  c8.senderId = Receiver_id;
  c8.receiverId = Sender_id;
  c8.msg = 'I am good. Can you do something for me? I need your help.';
  c8.time = '1:45 AM';
  list.add(c8);

  MessageModel c9 = MessageModel();
  c9.senderId = Sender_id;
  c9.receiverId = Receiver_id;
  c9.msg = 'I am good. Can you do something for me? I need your help.';
  c9.time = '1:45 AM';
  list.add(c9);

  MessageModel c10 = MessageModel();
  c10.senderId = Receiver_id;
  c10.receiverId = Sender_id;
  c10.msg = 'I am good. Can you do something for me? I need your help.';
  c10.time = '1:45 AM';
  list.add(c10);

  MessageModel c11 = MessageModel();
  c11.senderId = Receiver_id;
  c11.receiverId = Sender_id;
  c11.msg = 'I am good. Can you do something for me? I need your help.';
  c11.time = '1:45 AM';
  list.add(c11);

  MessageModel c12 = MessageModel();
  c12.senderId = Sender_id;
  c12.receiverId = Receiver_id;
  c12.msg = 'I am good. Can you do something for me? I need your help.';
  c12.time = '1:45 AM';
  list.add(c12);

  MessageModel c13 = MessageModel();
  c13.senderId = Sender_id;
  c13.receiverId = Receiver_id;
  c13.msg = 'I am good. Can you do something for me? I need your help.';
  c13.time = '1:45 AM';
  list.add(c13);

  MessageModel c14 = MessageModel();
  c14.senderId = Receiver_id;
  c14.receiverId = Sender_id;
  c14.msg = 'I am good. Can you do something for me? I need your help.';
  c14.time = '1:45 AM';
  list.add(c14);

  MessageModel c15 = MessageModel();
  c15.senderId = Sender_id;
  c15.receiverId = Receiver_id;
  c15.msg = 'I am good. Can you do something for me? I need your help.';
  c15.time = '1:45 AM';
  list.add(c15);

  MessageModel c16 = MessageModel();
  c16.senderId = Receiver_id;
  c16.receiverId = Sender_id;
  c16.msg = 'I am good. Can you do something for me? I need your help.';
  c16.time = '1:45 AM';
  list.add(c16);

  MessageModel c17 = MessageModel();
  c17.senderId = Sender_id;
  c17.receiverId = Receiver_id;
  c17.msg = 'I am good. Can you do something for me? I need your help.';
  c17.time = '1:45 AM';
  list.add(c17);

  MessageModel c18 = MessageModel();
  c18.senderId = Receiver_id;
  c18.receiverId = Sender_id;
  c18.msg = 'I am good. Can you do something for me? I need your help.';
  c18.time = '1:45 AM';
  list.add(c18);

  return list;
}
