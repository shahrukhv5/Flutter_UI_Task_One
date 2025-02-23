import 'package:flutter/material.dart';
import 'dart:async';
import 'Employee.dart';
import 'Services.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo({Key? key}) : super(key: key);

  final String title = 'Flutter Data Table';

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employees = [];
  List<Employee> _filterEmployees = [];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  Employee? _selectedEmployee;
  bool _isUpdating = false;
  String _titleProgress = '';
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _titleProgress = widget.title;
    _getEmployees();
  }

  void _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if (result == 'success') {
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  void _addEmployee() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if (result == 'success') {
        _getEmployees();
        _clearValues();
      }
    });
  }

  void _getEmployees() {
    _showProgress('Loading Employees...');
    Services.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
        _filterEmployees = employees;
      });
      _showProgress(widget.title);
      print("Length ${employees.length}");
    });
  }

  void _updateEmployee(Employee employee) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateEmployee(
            employee.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if (result == 'success') {
        _getEmployees();
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  void _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee(employee.id).then((result) {
      if (result == 'success') {
        _getEmployees();
      }
    });
  }

  void _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  void _showValues(Employee employee) {
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('FIRST NAME')),
            DataColumn(label: Text('LAST NAME')),
            DataColumn(label: Text('DELETE')),
          ],
          rows: _filterEmployees
              .map((employee) => DataRow(
                    cells: [
                      DataCell(
                        Text(employee.id),
                        onTap: () {
                          _showValues(employee);
                          _selectedEmployee = employee;
                          setState(() {
                            _isUpdating = true;
                          });
                        },
                      ),
                      DataCell(
                        Text(employee.firstName.toUpperCase()),
                        onTap: () {
                          _showValues(employee);
                          _selectedEmployee = employee;
                          setState(() {
                            _isUpdating = true;
                          });
                        },
                      ),
                      DataCell(
                        Text(employee.lastName.toUpperCase()),
                        onTap: () {
                          _showValues(employee);
                          _selectedEmployee = employee;
                          setState(() {
                            _isUpdating = true;
                          });
                        },
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteEmployee(employee);
                          },
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          hintText: 'Filter by First name or Last name',
        ),
        onChanged: (string) {
          _debouncer.run(() {
            setState(() {
              _filterEmployees = _employees
                  .where((u) =>
                      u.firstName
                          .toLowerCase()
                          .contains(string.toLowerCase()) ||
                      u.lastName.toLowerCase().contains(string.toLowerCase()))
                  .toList();
            });
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            _isUpdating
                ? Row(
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          _updateEmployee(_selectedEmployee!);
                        },
                        child: Text('UPDATE'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                        child: Text('CANCEL'),
                      ),
                    ],
                  )
                : Container(),
            searchField(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
