import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studlife_admin/AdminLogic.dart';

/*

THIS PAGE CONTAINS:
1-> Maintenance button
2-> Statistics display

*/

class MainPage extends StatefulWidget {
  final String specialCode;

  const MainPage({Key key, this.specialCode}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AdminLogic adminLogic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminLogic = AdminLogic(widget.specialCode);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adminLogic.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: adminLogic,
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<AdminLogic>(builder: (context, adminlogic, child) {
              if (adminlogic.mode == null) {
                adminlogic.getMode();
                return CircularProgressIndicator();
              } else
                return IgnorePointer(
                  ignoring: adminlogic.loading,
                  child: RaisedButton(
                    onPressed: () async {
                      await adminlogic.toggleMaintenance();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Maintenance ${adminLogic.mode ? "OFF" : "ON"}"),
                        if (adminlogic.loading) CircularProgressIndicator()
                      ],
                    ),
                  ),
                );
            }),
          ],
        ),
      )),
    );
  }
}
