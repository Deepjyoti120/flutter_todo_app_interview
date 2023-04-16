import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/services/models/employee.dart';

class HiveService {
  Future<void> initHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(EmployeeAdapter());
  }

  Future<LazyBox<Employee>> getEmployeeBox() async {
    return await Hive.openLazyBox<Employee>('employees');
  }
}
