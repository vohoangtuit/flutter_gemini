import 'package:flutter_gemini/utils/format_datetime.dart';

class Message{
  bool? isSend;
  String? text;
  int? type;
  String? timestamp;
  String? dateTime;

  Message({this.isSend, this.text, this.type, this.timestamp, this.dateTime});

  factory Message.newMessage({String? message, bool? send}){
    var now = DateTime.now();
    Message newMessage =Message(isSend: send,text: message,type: 1);
    newMessage.timestamp = now.microsecondsSinceEpoch.toString();
    newMessage.dateTime = FormatDateTime.strTodayFormatType(FormatType.YYYYMMDDHHmmss_);
    return newMessage;
  }
  factory Message.response(String message){
    var now = DateTime.now();
    Message newMessage =Message(isSend: false,text: message,type: 1);
    newMessage.timestamp = now.microsecondsSinceEpoch.toString();
    newMessage.dateTime = FormatDateTime.strTodayFormatType(FormatType.YYYYMMDDHHmmss_);
    return newMessage;
  }
}