import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/employee/add_employee_details.dart';
import 'package:todo_app/employee/employee_details_card.dart';
import 'package:todo_app/services/employee_provider.dart';
import 'package:todo_app/services/models/employee.dart';
import 'package:todo_app/ui/design_colors.dart';
import 'package:todo_app/ui/design_text.dart';
import 'package:todo_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      backgroundColor: DesignColor.todoBackground,
      appBar: AppBar(
        elevation: 0,
        title: const DesignText(
          'Employee List',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddEmployeeDetails(),
              ),
            );
          },
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      body: employeeProvider.isLoading
          ? const Center(
              child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )))
          : employeeProvider.employees.isEmpty
              ? Center(
                  child: SvgPicture.asset(
                    Constants.svgNodata,
                  ),
                )
              : const AllEmployees(),
    );
  }
}

class AllEmployees extends StatelessWidget {
  const AllEmployees({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    var newEmployee =
        employeeProvider.employees.where((element) => element.active).toList();
    var pastEmployee =
        employeeProvider.employees.where((element) => !element.active).toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (newEmployee.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: DesignText(
                'Current employees',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DesignColor.backgroundColor,
              ),
            ),
          ListView.builder(
            itemCount: newEmployee.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final sortedList = newEmployee
                ..sort((a, b) => a.position.compareTo(b.position));
              final data =
                  sortedList.where((element) => element.active).toList()[index];
              // final data = employeeProvider.employees[index];
              return Dismissible(
                  key: Key(data.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // final index2 =
                    //     employeeProvider.employees.indexOf(data);
                    employeeProvider.removeEmployee(data);
                    // employeeProvider.refresh =
                    //     !employeeProvider.refresh;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const DesignText(
                          'Employee data has been deleted',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            employeeProvider.updateEmployee(data);
                            // employeeProvider.refresh =
                            //     !employeeProvider.refresh;
                          },
                        ),
                      ),
                    );
                  },
                  background: Container(
                    height: 104,
                    color: DesignColor.red,
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: EmployeeCard(employee: data));
            },
          ),
          if (pastEmployee.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: DesignText(
                'Previous employees',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DesignColor.backgroundColor,
              ),
            ),
          ListView.builder(
            itemCount: pastEmployee.toList().length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final sortedList = pastEmployee
                ..sort((a, b) => a.position.compareTo(b.position));
              final data = sortedList
                  .where((element) => !element.active)
                  .toList()[index];
              return Dismissible(
                  key: Key(data.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    employeeProvider.removeEmployee(data);
                    // employeeProvider.refresh =
                    //     !employeeProvider.refresh;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const DesignText(
                          'Employee data has been deleted',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            employeeProvider.updateEmployee(data);
                            // employeeProvider.refresh =
                            //     !employeeProvider.refresh;
                          },
                        ),
                      ),
                    );
                  },
                  background: Container(
                    height: 104,
                    color: DesignColor.red,
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: EmployeeCard(employee: data));
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: DesignText(
              'Swipe left to delete',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: DesignColor.textnotFocus,
            ),
          ),
        ],
      ),
    );
  }
}
