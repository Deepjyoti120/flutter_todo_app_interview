import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/employee/edit_employee_details.dart';
import 'package:todo_app/services/models/employee.dart';
import 'package:todo_app/ui/design_colors.dart';
import 'package:todo_app/ui/design_text.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    Key? key,
    required this.employee,
  }) : super(key: key);
  final Employee employee;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditEmployeeDetails(employee: employee),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: Container(
          height: 104,
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DesignText(
                  employee.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: DesignColor.textFocus,
                ),
                const SizedBox(height: 6),
                DesignText(
                  employee.rule,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: DesignColor.textnotFocus,
                ),
                const SizedBox(height: 6),
                DesignText(
                  employee.active
                      ? 'From ${DateFormat('d MMM, y').format(employee.joinDate)}'
                      : 'From ${DateFormat('d MMM, y').format(employee.joinDate)} - ${DateFormat('d MMM, y').format(employee.endDate!)}',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: DesignColor.textnotFocus,
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
