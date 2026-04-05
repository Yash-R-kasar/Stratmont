import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stratmont/constants/constant.dart';

Future postReq(url, [token = '', payload = const []]) async {
  var res = await http.post(
    Uri.parse(baseUrl + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer $token',
    },
    body: jsonEncode(payload),
  );
  return res;
}

Future patchReq(url, [token = '', payload = const []]) async {
  return await http.patch(
    Uri.parse(baseUrl + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer $token',
    },
    body: jsonEncode(payload),
  );
}

Future putReq(url, [token = '', payload = const []]) async {
  return await http.put(
    Uri.parse(baseUrl + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer $token',
    },
    body: jsonEncode(payload),
  );
}

Future getReq(url, [token = "", context]) async {
  var res = await http.get(
    Uri.parse(baseUrl + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer $token',
    },
  );
  return res;
}

Future deleteReq(url, [token = ""]) async {
  return await http.delete(
    Uri.parse(baseUrl + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer $token',
    },
  );
}
