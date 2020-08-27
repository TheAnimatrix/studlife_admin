import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studlife_admin/AdminLogic.dart';
import 'package:studlife_admin/AuthLogic.dart';
import 'package:studlife_admin/MainPage.dart';

import 'AuthPage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("reloaded");
    bool authenticated = Provider.of<bool>(context);
    if(authenticated)
    {
      return MainPage(specialCode: Provider.of<AuthLogic>(context,listen: false).specialCode,); //AuthPage()
    }else{
      return AuthPage();
    }
  }

}