import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:todo_app/services/employee_provider.dart';
import 'package:todo_app/services/models/employee.dart';
import 'package:todo_app/ui/custom_date_picker.dart';
import 'package:todo_app/ui/custom_form_field.dart';
import 'package:todo_app/ui/design_colors.dart';
import 'package:todo_app/ui/design_text.dart';
import 'package:todo_app/utils/design_utlis.dart';

class EditEmployeeDetails extends StatefulWidget {
  const EditEmployeeDetails({
    Key? key,
    required this.employee,
  }) : super(key: key);
  final Employee employee;
  @override
  State<EditEmployeeDetails> createState() => _EditEmployeeDetailsState();
}

class _EditEmployeeDetailsState extends State<EditEmployeeDetails> {
  final name = TextEditingController();
  final rule = TextEditingController();
  final join = TextEditingController();
  final end = TextEditingController();
  DateTime? joinDateTime;
  DateTime? endDateTime;
  final date = DateTime.now();
  @override
  void initState() {
    super.initState();
    setInit();
  }

  Future setInit() async {
    name.text = widget.employee.name;
    rule.text = widget.employee.rule;
    joinDateTime = widget.employee.joinDate;
    join.text = DesignUtils.isSameDateTime(widget.employee.joinDate, date)
        ? 'Today'
        : DateFormat('d MMM y').format(widget.employee.joinDate);
    if (widget.employee.endDate != null) {
      end.text = DesignUtils.isSameDateTime(widget.employee.endDate!, date)
          ? 'Today'
          : DateFormat('d MMM y').format(widget.employee.endDate!);
      endDateTime = widget.employee.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final formState = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const DesignText(
            'Edit Employee Details',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  employeeProvider.removeEmployee(widget.employee);
                  Navigator.pop(context);
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
                          employeeProvider.updateEmployee(widget.employee);
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.trashCan,
                  size: 18,
                )),
            const SizedBox(width: 6),
          ],
        ),
        body: Form(
          key: formState,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: name,
                          icon: Icons.person_outline,
                          hintText: 'Employee name',
                          validator: 'Please Enter Employee name',
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16))),
                              builder: (context) => RuleSelect(
                                onTap: (p0) {
                                  rule.text = p0;
                                },
                              ),
                            );
                          },
                          child: CustomFormField(
                            controller: rule,
                            icon: Icons.work_outline,
                            hintText: 'Select role',
                            suffixIcon: FontAwesomeIcons.caretDown,
                            enabled: false,
                            validator: 'Please Select an role',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDatePicker(
                                        initialDate:
                                            joinDateTime ?? DateTime.now()),
                                  ).then((value) {
                                    if (value != null) {
                                      join.text = DesignUtils.isSameDateTime(
                                              value['dateTime'], joinDateTime!)
                                          ? 'Today'
                                          : DateFormat('d MMM y')
                                              .format(value['dateTime']);
                                      joinDateTime = value['dateTime'];
                                    }
                                  });
                                },
                                child: CustomFormField(
                                  controller: join,
                                  icon: Icons.event_rounded,
                                  hintText: 'Today',
                                  enabled: false,
                                  validator: 'Please Select Joining Date',
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(
                                FontAwesomeIcons.arrowRight,
                                size: 14,
                                color: DesignColor.todoBlue,
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDatePicker(
                                        isNoDate: true,
                                        initialDate:
                                            endDateTime ?? DateTime.now()),
                                  ).then((value) {
                                    if (value != null) {
                                      if (!value['isNoDate']) {
                                        end.text = DesignUtils.isSameDateTime(
                                                value['dateTime'], date)
                                            ? 'Today'
                                            : DateFormat('d MMM y')
                                                .format(value['dateTime']);
                                        endDateTime = value['dateTime'];
                                      } else {
                                        end.clear();
                                        endDateTime = null;
                                        setState(() {});
                                      }
                                    }
                                  });
                                },
                                child: CustomFormField(
                                  controller: end,
                                  icon: Icons.event_rounded,
                                  hintText: 'No date',
                                  enabled: false,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 0, thickness: 2, color: DesignColor.color6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 64,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: DesignColor.backgroundColor1,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const DesignText(
                              'Cancel',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 40,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: DesignColor.backgroundColor,
                            ),
                            onPressed: () {
                              if (kDebugMode) {
                                print(employeeProvider.employees
                                    .map((e) => {
                                          'id': e.id,
                                          'name': e.name,
                                          'joinDate': e.joinDate,
                                          'rule': e.rule,
                                          'endDate': e.endDate,
                                          'active': e.active,
                                          'position': e.position,
                                        })
                                    .toList());
                              }
                              if (formState.currentState!.validate()) {
                                employeeProvider.editEmployee(
                                    widget.employee,
                                    Employee(
                                      id: widget.employee.id,
                                      name: name.text.trim(),
                                      joinDate: joinDateTime!,
                                      rule: rule.text.trim(),
                                      endDate: endDateTime,
                                      active: endDateTime == null,
                                      position: widget.employee.position,
                                    ));
                                Navigator.pop(context);
                              }
                            },
                            child: const DesignText(
                              'Save',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class RuleSelect extends StatelessWidget {
  const RuleSelect({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    final List<String> rules = [
      'Product Designer',
      'Flutter Developer',
      'QA Tester',
      'Product Owner'
    ];
    return ListView.builder(
      itemCount: rules.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        String rule = rules[index];
        return InkWell(
          onTap: () {
            onTap(rule);
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                child: DesignText(
                  rule,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Divider(height: 0, thickness: 2, color: DesignColor.color6),
            ],
          ),
        );
      },
    );
  }
}
