import 'dart:html';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTrranlationPage extends StatefulWidget {
  const LanguageTrranlationPage({super.key});

  @override
  State<LanguageTrranlationPage> createState() => _LanguageTrranlationPageState();
}

class _LanguageTrranlationPageState extends State<LanguageTrranlationPage> {

  var languages =['Hindi', 'English','Spainish'];
  var originalLanguages = "From";
  var destinationLanguage ="To";
  var output = "";
  TextEditingController languageController =TextEditingController();

  void translate (String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input,from: src,to: dest);
    setState(() {
      output= translation.text.toString();
    });

    if(src == '--' || dest == '--'){
      setState(() {
        output = 'failed to translate';
      });
    }
  }

  String getLanguageCode(String language){
    if(language == "English"){
      return "en";
    }
    else if(language == "Hindi"){
      return "hi";
    }
    else if(language == "Spainish"){
      return "es";
    }
    else
      {
        return "--";
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(title: Text('Language Tranlator'),centerTitle: true,
      backgroundColor: Colors.pinkAccent.shade400,
      elevation: 5,),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 55,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white12,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.blue,
                    hint: Text(originalLanguages,style: TextStyle(
                      color: Colors.blueGrey
                    ),),
                    dropdownColor: Colors.blue.shade50,
                    icon: Icon(Icons.keyboard_alt_outlined),
                    items: languages.map((String dropDownStringItem){
                      return DropdownMenuItem(child: Text(dropDownStringItem),
                  value: dropDownStringItem);
                  }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        originalLanguages = value! ;
                      });
                    },
                  ),

                  SizedBox(width: 50,),
                  Icon(Icons.arrow_forward_sharp, color: Colors.amber.shade700,),
                  SizedBox(width: 50,),

                  DropdownButton(
                    focusColor: Colors.grey,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.blue,
                    hint: Text(destinationLanguage,style: TextStyle(
                        color: Colors.blueGrey
                    ),),
                    dropdownColor: Colors.blue.shade50,
                    icon: Icon(Icons.keyboard_alt_outlined),
                    items: languages.map((String dropDownStringItem){
                      return DropdownMenuItem(child: Text(dropDownStringItem),
                          value: dropDownStringItem);
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        destinationLanguage = value! ;
                      });
                    },
                  ),

                ],
              ),

              SizedBox(height: 25,),
              Padding(padding: EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white24,
                autofocus: false,
                style: TextStyle(color: Colors.blue.shade200),
                decoration: InputDecoration(
                  labelText: 'Please enter your text',
                  labelStyle: TextStyle(fontSize: 15,color: Colors.pink),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white12,
                      width: 2,
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white12,
                      width: 2,
                    ),
                  ),
                  errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                ),
                controller: languageController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter text';
                  }
                  return null;
                },
              ),),

              Padding(padding: EdgeInsets.all(8.0,),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white24),
                  onPressed: (){
                    translate(getLanguageCode(originalLanguages),getLanguageCode(destinationLanguage),languageController.text.toString());
                  },
                  child: Text('translate')),),

              SizedBox(height: 20,),
              Text("\n$output", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.pink.shade300,

              ),)
            ],
          ),
        ),
      ),
    );
  }
}
