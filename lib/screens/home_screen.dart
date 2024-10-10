import 'package:flutter/material.dart';
import 'package:flutter_gemini/google_generate/google_generate_service.dart';
import 'package:flutter_gemini/models/message.dart';
import 'package:flutter_gemini/screens/items/item_message.dart';
import 'package:flutter_gemini/utils/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController =TextEditingController();
 // var model = GenerativeModel(
 //  model: 'gemini-1.5-flash-latest',
 //  apiKey: 'AIzaSyCk-imcydUb1AFL9HpWJhzX-9_jfCfbhEs',
 //  );
   var service =GoogleGenerateService.instance..getInstance();

  List<Message> data=[];
  double screenWidth =0;
   final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text(
        'Vietravel ChatBox',style: TextStyle(
        fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold
      ),
      ),),
      body: _viewContent(),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Widget _viewContent(){
    return    GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: [
          _viewList(),
          _viewInput()
        ],
      ),
    );
  }
  Widget _viewList(){
    return Expanded(
        child: ListView.builder(
          itemCount: data.length,
        controller: _scrollController,
        //shrinkWrap: true,
        padding: EdgeInsets.only(left: 10,right: 10),
        physics: ClampingScrollPhysics(),
        itemBuilder: (_, index)=>ItemMessage(item:data[index],screenWidth: screenWidth,)
    ));
  }
  Widget _viewInput(){
    return Column(
      children: [
        Divider(height: 1,),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration:  InputDecoration(
                    hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 10,right: 10),
                    border: InputBorder.none,
                    hintText: 'Enter your message....',
                  ),
                ),
              ),
              IconButton(
                onPressed: _getImage,
                icon: const Icon(
                  Icons.image_outlined,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: _sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

        ),
      ],
    );
  }
  Future _getImage()async{
    final pickedImage = await pickImage();
    if (pickedImage == null) {
      return;
    }
    _sendMessageImage(pickedImage);
  }
  /// --- text
  Future _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    _updateList(_messageController.text,true);
    _messageController.clear();

    final response= await service.sendTextMessage(message);

    _updateList(response,false);

    
  }
  _updateList(String text, bool send){
    if(mounted){
      setState(() {
        data.add(Message.newMessage(message: text,send: send));
      });
      _scrollToBottom();
    }
  }
  ///----- image
  Future _sendMessageImage(XFile file)async{
    _updateListWithImage(file.path,true);
    // final imageBytes = await file.readAsBytes();
    // final mimeType = file.mimeType;
    // final imagePart = DataPart(mimeType.toString(), imageBytes);
    // final content = [Content.data('please description this image',imagePart.bytes)];
 //   final response = await model.generateContent(content);
    final response= await service.sendImageMessage(file);
    _updateList(response,false);
  }
  _updateListWithImage(String path,bool send){
    if(mounted){
      setState(() {
        data.add(Message.newMessageImage(path: path,send: send));
      });
    }
  }
  _scrollToBottom(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 100),
      );
    });

  }
}
