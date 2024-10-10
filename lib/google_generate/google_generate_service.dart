
import 'package:flutter_gemini/utils/extensions.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class GoogleGenerateService{
  static GoogleGenerateService?_instance;
   GenerativeModel? generate;
  String error='Error something...';

  static final GoogleGenerateService instance = GoogleGenerateService._internal();
  factory GoogleGenerateService() {
    return instance;
  }
  GoogleGenerateService._internal();

   getInstance() async {
    _instance ??= GoogleGenerateService();
    generate ??= GenerativeModel(
      //model: 'gemini-1.5-flash-latest',gemini-1.5-flash
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCk-imcydUb1AFL9HpWJhzX-9_jfCfbhEs',
      // https://aistudio.google.com/app/apikey
    );
    return _instance;
  }
  Future<String> sendTextMessage(String text)async{
    final content = [Content.text(text)];
    final response = await generate!.generateContent(content);
    if(response.text!=null){
      return response.text!;
    }
    return error;
  }
  Future<String> sendImageMessage(XFile file)async{
    final imageBytes = await file.readAsBytes();
    final prompt = TextPart(file.name);
    final mimeType = file.getMimeTypeFromExtension();
    final imagePart = DataPart(mimeType, imageBytes);
   // final content = [Content.data(file.name,imagePart.bytes)];
    final content = [Content.multi([prompt,imagePart])];
    final response = await generate!.generateContent(content);
    if(response.text!=null){
      return response.text!;
    }
    return error;
  }
}