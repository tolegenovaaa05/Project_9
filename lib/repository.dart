import 'dart:convert';
import 'package:http/http.dart' as http;

class Repository {
  Future<List<Map<String, dynamic>>> fetchTodos() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> todoList = json.decode(response.body);
      return todoList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
