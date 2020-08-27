import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studlife_admin/AuthLogic.dart';
import 'package:studlife_admin/AuthPage.dart';

import 'Wrapper.dart';

void main() {
  runApp(Provider(
      create: (context) => AuthLogic(),
      dispose: (ctx, al) => al.dispose(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: StreamProvider.value(
          value: Provider.of<AuthLogic>(context).Authenticated as Stream<bool>,
          child: Wrapper()),
    );
  }
}
