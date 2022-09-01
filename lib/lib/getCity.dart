import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&lang=pt_br&appid=569c4c13a3ad294850d4f739adb1d54c&q=";
Future<Map> getCity(String search) async{
  http.Response response;

  response = await http.get(Uri.parse(baseUrl + search));

  return json.decode(response.body);
}