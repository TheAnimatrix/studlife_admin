import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studlife_admin/AuthLogic.dart';

class AdminLogic extends ChangeNotifier {
  bool mode;
  Dio dio;
  String special;
  bool loading = false;

  AdminLogic(String code) {
    special = code ?? "9790795165";
    dio = new Dio()
      ..options = BaseOptions(
          baseUrl: "http://183.83.48.186", validateStatus: (v) => true);
    mode = null;
  }

  getMode() async {
    try {
      Response response = await dio.post('/admin/status',
          data: {"special": special ?? "9790795165"},
          options: Options(contentType: "application/json"));
      if (response.statusCode == 200) {
        mode = response.data["status"];
      } else
        mode = false;
    } catch (e) {
      mode = false;
    }
    notifyListeners();
  }

  toggleMaintenance() async {
    loading = true;
    notifyListeners();
    await _toggleMaintenance();
    loading = false;
    notifyListeners();
  }

  _toggleMaintenance() async {
    try {
      Response r;
      if (mode != null && !mode) {
        //ON
        r = await dio.post('/admin/premaintenance', data: {"special": special});
      } else if (mode != null && mode) {
        //OFF
        r = await dio
            .post('/admin/postmaintenance', data: {"special": special});
      }

      if (r.statusCode != 200) {
        print("toggle maintenance status err ${r.statusCode} ${r.data}");
      } else {
        mode = !mode;
        notifyListeners();
      }
      return r.statusCode == 200;
    } catch (e) {
      print("toggle maintenenace error $e");
      return false;
    }
  }
}
