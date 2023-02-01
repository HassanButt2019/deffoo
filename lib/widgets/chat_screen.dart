

// ignore: must_be_immutable
import 'package:deffo/Eco_Host/Auth/booking_model.dart';
import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  bool status;
  ChatScreen(this.status);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController msgController = TextEditingController();
  FocusNode msgFocusNode = FocusNode();
  var msgListing = getChatMsgData();
  var personName = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  sendClick() async {
    DateFormat formatter = DateFormat('hh:mm a');

    if (msgController.text.trim().isNotEmpty) {
      hideKeyboard(context);
      var msgModel = MessageModel();
      msgModel.msg = msgController.text.toString();
      msgModel.time = formatter.format(DateTime.now());
      msgModel.senderId = Sender_id;
      hideKeyboard(context);
      msgListing.insert(0, msgModel);

      var msgModel1 = MessageModel();
      msgModel1.msg = msgController.text.toString();
      msgModel1.time = formatter.format(DateTime.now());
      msgModel1.senderId = Receiver_id;

      msgController.text = '';

      if (mounted) scrollController.animateTo(   0,
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,);
      FocusScope.of(context).requestFocus(msgFocusNode);
      setState(() {});

      await Future.delayed(Duration(seconds: 1));

      msgListing.insert(0, msgModel1);

      if (mounted) scrollController.animateTo(   0,
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,);
    } else {
      FocusScope.of(context).requestFocus(msgFocusNode);
    }

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: widget.status?0:50,
        leading: widget.status?SizedBox():GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: Row(
          children: <Widget>[
            CircleAvatar(backgroundImage: AssetImage("assets/ecostay/Profile.png"), radius: 16),
            SizedBox(width: 8,),
            Text("Chat Bot", style: TextStyle(color: Color(0xFF2E3033), fontSize: 16)),
          ],
        ),
        actions: [
        //  Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.call, color: Color(0xFF2E3033), size: 20)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            decoration: BoxDecoration(color: Colors.white),
            child: ListView.separated(
              separatorBuilder: (_, i) => Divider(color: Colors.transparent),
              shrinkWrap: true,
              reverse: true,
              controller: scrollController,
              itemCount: msgListing.length,
              padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: widget.status?150:70),
              itemBuilder: (_, index) {
                MessageModel data = msgListing[index];
                var isMe = data.senderId == Sender_id;
                return ChatMessageWidget(isMe: isMe, data: data);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: widget.status?80:8),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset:  const Offset(0.0, 0.0),
                )
              ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      focusNode: msgFocusNode,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration.collapsed(
                        hintText: personName.isNotEmpty ? 'Write to ${"Chat Bot"}' : 'Type a message',
                        hintStyle:TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal,color: Color(0xFF2E3033)),
                      ),
                      style:TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal,color: Color(0xFF2E3033)),
                      onSubmitted: (s) {
                        sendClick();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, size: 25),
                    onPressed: () async {
                      sendClick();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.isMe,
    required this.data,
  }) : super(key: key);

  final bool isMe;
  final MessageModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          margin: isMe ? EdgeInsets.only(top: 3.0, bottom: 3.0, right: 0, left: (500 * 0.25).toDouble()) : EdgeInsets.only(top: 4.0, bottom: 4.0, left: 0, right: (500 * 0.25).toDouble()),
          decoration: BoxDecoration(
            color: !isMe ? Colors.red.withOpacity(0.85) : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset:  const Offset(0.0, 0.0),
              )
            ],
            borderRadius: isMe
                ? BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10))
                : BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
            border: Border.all(color: isMe ? Theme.of(context).dividerColor : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  data.msg!,
                  style: TextStyle(
                      color: !isMe
                          ? Colors.white
                          : Color(0xFF2E3033),fontSize: 16.0,fontWeight: FontWeight.normal),
                ),
              ),
              Text(data.time!, style: TextStyle(color: !isMe ? Colors.white :  Color(0xFF757575), fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
