import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/utils/format_datetime.dart';

import '../../models/message.dart';

class ItemMessage extends StatefulWidget {
  final Message item;
  final double screenWidth;
  const ItemMessage({super.key, required this.item, required this.screenWidth});

  @override
  State<ItemMessage> createState() => _ItemMessageState();
}

class _ItemMessageState extends State<ItemMessage> {
  double div =1.5;
  @override
  Widget build(BuildContext context) {
    return _itemBuilder(widget.item);
  }
  Widget _itemBuilder(Message item){
    return item.isSend!?_itemRequest(item):_itemResponse(item);
  }
  Widget _itemRequest(Message item){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: widget.screenWidth/div,
          margin: EdgeInsets.only(top: 5,bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _time(item.dateTime!,true),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: item.type==TypeMessage.text?Container(
                        decoration: bgItem(Colors.orangeAccent.shade100),
                        padding: EdgeInsets.all(10),
                        child: Text(item.text!.trimRight()),
                  ):_typeImage(item),)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _typeImage(Message item){
    return Image.file(
      File(item.pathLocalImage!),
      fit: BoxFit.cover,
    );
  }
  Widget _itemResponse(Message item){
    return  Row(
      children: [
        Container(
        width: widget.screenWidth/div,
            margin: EdgeInsets.only(top: 5,bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: _time(item.dateTime!,false),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: bgItem(Colors.blueGrey.shade300),
                    child: Text(item.text!.trimRight(),)
                ),
              ],
            )),
      ],
    );
  }
  BoxDecoration bgItem(Color color) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    );
  }
  Widget  _time(String time,bool isSend){
    return Text(FormatDateTime.strFormatTypeInOut(time,FormatType.YYYYMMDDHHmmss_,FormatType.hhMM ),style: TextStyle(color: Colors.grey,fontSize:12 ));
  }
}
