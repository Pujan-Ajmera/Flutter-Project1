import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiData{
  Future<List<Map<String,dynamic>>> getAllUsers()async{
    final url = Uri.parse("https://66f274a771c84d80587551d2.mockapi.io/movie");
    final response = await http.get(url);
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    return data;
  }

  Future<void> addUser(Map<String,dynamic> user)async{
    final url = Uri.parse("https://66f274a771c84d80587551d2.mockapi.io/movie");
    final response = await http.post(url,headers:{"Content-Type": "application/json"},
        body: jsonEncode(user),);
  }
  Future<void> deleteUser(String id)async{
    final url = Uri.parse("https://66f274a771c84d80587551d2.mockapi.io/movie/${id}");
    final response = await http.delete(url);
  }
  Future<void> updateUser(String id,Map<String,dynamic> user)async{
    final url = Uri.parse("https://66f274a771c84d80587551d2.mockapi.io/movie/${id}");
    final response = await http.put(url,
      headers:{"Content-Type": "application/json"},
      body: jsonEncode(user),);
  }
}

