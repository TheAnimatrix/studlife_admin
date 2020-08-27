import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studlife_admin/AuthLogic.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  TextEditingController _textController = TextEditingController();
  String errorText = null;
  bool loading = false;

  submit() async
  {
    setState(() { errorText = ""; });
    if(_textController == null || _textController.text.isEmpty || _textController.text.length < 6) {
      setState(() {
        errorText = "Special code format is not valid";
      });
      return false;
    }

    //authenticate
    setState(() {
      errorText = "";
      loading = true;
    });
    try{
      await Future.delayed(Duration(milliseconds: 100));
      await Provider.of<AuthLogic>(context,listen:false).authenticate(specialCode: _textController.text);
      setState(() {
        loading = false;
        errorText = null;
      });
    }catch(e)
    {
      print("error occured $e");
      setState(() {
        errorText = e["message"];
        loading = false;
      });

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Column(children: [
            Text("Studlife Admin"),
            SizedBox(height: 100,),
            Text("Special code please..."),
            TextField(decoration: InputDecoration(hintText: "bruh...",errorText: errorText),controller: _textController,),
            RaisedButton(child:Text("Authenticate!"),onPressed: submit,)
          ],),),
          if(loading)Container(color:Colors.black38,child: Center(child: CircularProgressIndicator(),))
        ],
      ),
    );
  }
}