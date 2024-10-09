import 'package:flutter/material.dart';
import 'package:flutter_gemini/models/message.dart';
import 'package:flutter_gemini/screens/items/item_message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController =TextEditingController();
  /// api key: AIzaSyCbtkkiR3iwR2cP3N6uN8yjooRO8Bj_9r8
  /// project number: 437455981233
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyCbtkkiR3iwR2cP3N6uN8yjooRO8Bj_9r8',
  );

  List<Message> data=[];
  double screenWidth =0;
   var _scrollController = ScrollController();

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
                onPressed: _sendMessage,
                icon: const Icon(
                  Icons.send,
                ),
              ),
            ],
          ),

        ),
      ],
    );
  }
  Future _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    _updateList(_messageController.text,true);
    _messageController.clear();
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    _updateList(response.text!,false);
   // print(response.text);
    
  }
  _updateList(String text, bool send){
    if(mounted){
      setState(() {
        data.add(Message.newMessage(message: text,send: send));
      });
      _scrollToBottom();
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
