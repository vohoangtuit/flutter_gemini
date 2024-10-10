import 'package:flutter_gemini/utils/format_datetime.dart';

enum TypeMessage {
  text,
  image,
  video,
}
class Message{
  bool? isSend;
  String? text;
  TypeMessage? type;
  String? urlImage;
  String? pathLocalImage;
  String? timestamp;
  String? dateTime;

  Message({this.isSend, this.text, this.type,this.urlImage,this.pathLocalImage, this.timestamp, this.dateTime});

  factory Message.newMessage({String? message, bool? send}){
    var now = DateTime.now();
    Message newMessage =Message(isSend: send,text: message,type: TypeMessage.text);
    newMessage.timestamp = now.microsecondsSinceEpoch.toString();
    newMessage.dateTime = FormatDateTime.strTodayFormatType(FormatType.YYYYMMDDHHmmss_);
    return newMessage;
  }
  factory Message.newMessageImage({String? path, bool? send}){
    var now = DateTime.now();
    Message newMessage =Message(text:'',isSend: send,pathLocalImage: path,type: TypeMessage.image);
    newMessage.timestamp = now.microsecondsSinceEpoch.toString();
    newMessage.dateTime = FormatDateTime.strTodayFormatType(FormatType.YYYYMMDDHHmmss_);
    return newMessage;
  }
  factory Message.response(String message){
    var now = DateTime.now();
    Message newMessage =Message(isSend: false,text: message,type: TypeMessage.text);
    newMessage.timestamp = now.microsecondsSinceEpoch.toString();
    newMessage.dateTime = FormatDateTime.strTodayFormatType(FormatType.YYYYMMDDHHmmss_);
    return newMessage;
  }
}