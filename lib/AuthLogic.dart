
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
class AuthLogic
{

  //Auth http calls and so forth
  StreamController<bool> authenticatedStatus;
  String specialCode;
  bool authenticated = false;
  Dio dio;
  AuthLogic()
  {
    dio = new Dio()..options = BaseOptions(baseUrl: "http://183.83.48.186",validateStatus: (v)=>true );
    authenticated = false;
    authenticatedStatus = new StreamController();
    authenticatedStatus.add(false);
  }

  Stream get Authenticated {
    return authenticatedStatus.stream;
  }

  void logout()
  {
    specialCode = null;
    authenticated = false;
    authenticatedStatus.sink.add(false);
  }

  authenticate({String specialCode}) async
  {
    try{
      await authenticateHttp(code:specialCode);
      this.specialCode = specialCode;
      this.authenticated = true;
      authenticatedStatus.sink.add(true);
    }catch(err)
    {
      //err
      throw err;
    }
  }

  Future<void> authenticateHttp({String code}) async
  {
    try{
      var response = await dio.post("/admin/status",data: {"special":code},options: Options(contentType: "application/json"));
      if(response.statusCode != 200)
        throw {"status":401, "message":response.data.toString()};
      return;
    }catch(e)
    {
      throw {"code":401,"message":e.toString()};
    }
  }

  dispose()
  {

  }

}