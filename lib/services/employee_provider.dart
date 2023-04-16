import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/services/models/employee.dart';

class EmployeeProvider with ChangeNotifier {
  late Box<Employee> _employeeBox;
  bool _isLoading = true;
  // bool _refresh = false;
  EmployeeProvider() {
    initializeHive();
  }

  Future<void> initializeHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    Hive.registerAdapter(EmployeeAdapter());
    _employeeBox = await Hive.openBox<Employee>('employeeBox');
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  // bool get refresh => _refresh;
  List<Employee> get employees {
    return _employeeBox.values.toList();
  }

  set addEmployee(Employee employee) {
    _employeeBox.add(employee);
    notifyListeners();
  }

  void removeEmployee(Employee data) {
    final index = employees.indexOf(data);
    _employeeBox.deleteAt(index);
    notifyListeners();
  }

  void updateEmployee(Employee employee) {
    _employeeBox.put(employee.id, employee);
    notifyListeners();
  }

  void editEmployee(Employee data,Employee employee) {
    final index = employees.indexOf(data);
    _employeeBox.putAt(index, employee);
    notifyListeners();
  }

  // set refresh(bool refresh) {
  //   _refresh = refresh;
  //   notifyListeners();
  // }
}
