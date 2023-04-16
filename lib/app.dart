import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/services/employee_provider.dart';
import 'package:todo_app/theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: MaterialApp(
        title: 'TODO Task',
        routes: appRoutes,
        themeMode: ThemeMode.light,
        theme: theme,
        darkTheme: darkTheme,
      ),
    );
  }
}
