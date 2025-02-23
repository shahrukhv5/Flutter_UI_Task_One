import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employee.dart';

class Services {
  static const String ROOT =
      'http://192.168.120.142/EmployeesDB/employee_actions.php';
  static const String _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const String _GET_ALL_ACTION = 'GET_ALL';
  static const String _ADD_EMP_ACTION = 'ADD_EMP';
  static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      var map = <String, String>{};
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Create Table Response: ${response.body}');
      return response.statusCode == 200 ? response.body : "error";
    } catch (e) {
      print("Error in createTable: $e");
      return "error";
    }
  }

  static Future<List<Employee>> getEmployees() async {
    try {
      var map = <String, String>{};
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getEmployees Response: ${response.body}');
      if (response.statusCode == 200) {
        return parseResponse(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print("Error in getEmployees: $e");
      return []; // return an empty list on exception/error
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final List<dynamic> parsed = json.decode(responseBody);
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  // Method to add an employee to the database...
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = <String, String>{};
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addEmployee Response: ${response.body}');
      return response.statusCode == 200 ? response.body : "error";
    } catch (e) {
      print("Error in addEmployee: $e");
      return "error";
    }
  }

  // Method to update an Employee in the Database...
  static Future<String> updateEmployee(
      String empId, String firstName, String lastName) async {
    try {
      var map = <String, String>{};
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('updateEmployee Response: ${response.body}');
      return response.statusCode == 200 ? response.body : "error";
    } catch (e) {
      print("Error in updateEmployee: $e");
      return "error";
    }
  }

  // Method to delete an Employee from the Database...
  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = <String, String>{};
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteEmployee Response: ${response.body}');
      return response.statusCode == 200 ? response.body : "error";
    } catch (e) {
      print("Error in deleteEmployee: $e");
      return "error";
    }
  }
}
