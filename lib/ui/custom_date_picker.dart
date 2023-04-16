import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/ui/design_colors.dart';
import 'package:todo_app/ui/design_text.dart';
import 'package:todo_app/utils/design_utlis.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    this.isNoDate = false,
    required this.initialDate,
  }) : super(key: key);
  final bool isNoDate;
  final DateTime initialDate;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;
  late DateTime btnselectedDate;
  bool isNoDate = false;
  @override
  void initState() {
    super.initState();
    getInit();
  }

  Future getInit() async {
    final datetime = DateTime.now();
    _selectedDate = widget.initialDate;
    btnselectedDate = datetime;
    isNoDate = widget.isNoDate;
    if (!DesignUtils.isSameDateTime(widget.initialDate, datetime)) {
      isNoDate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (!isNoDate && !widget.isNoDate)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: DesignUtils.isSameDateTime(
                                        _selectedDate, btnselectedDate)
                                    ? DesignColor.backgroundColor
                                    : DesignColor.backgroundColor1,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedDate = DateTime.now();
                                });
                              },
                              child: DesignText(
                                'Today',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: DesignUtils.isSameDateTime(
                                        _selectedDate, btnselectedDate)
                                    ? Colors.white
                                    : null,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: DesignUtils.isSameDateTime(
                                          _selectedDate,
                                          btnselectedDate
                                              .add(const Duration(days: 1)))
                                      ? DesignColor.backgroundColor
                                      : DesignColor.backgroundColor1,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedDate = DateTime.now()
                                        .add(const Duration(days: 1));
                                  });
                                },
                                child: DesignText(
                                  'Next ${DateFormat('EEEE').format(btnselectedDate.add(const Duration(days: 1)))}',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: DesignUtils.isSameDateTime(
                                          _selectedDate,
                                          btnselectedDate
                                              .add(const Duration(days: 1)))
                                      ? Colors.white
                                      : null,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: DesignUtils.isSameDateTime(
                                        _selectedDate,
                                        btnselectedDate
                                            .add(const Duration(days: 2)))
                                    ? DesignColor.backgroundColor
                                    : DesignColor.backgroundColor1,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedDate = DateTime.now()
                                      .add(const Duration(days: 2));
                                });
                              },
                              child: DesignText(
                                'Next ${DateFormat('EEEE').format(btnselectedDate.add(const Duration(days: 2)))}',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: DesignUtils.isSameDateTime(
                                        _selectedDate,
                                        btnselectedDate
                                            .add(const Duration(days: 2)))
                                    ? Colors.white
                                    : null,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: DesignUtils.isSameDateTime(
                                          _selectedDate,
                                          btnselectedDate
                                              .add(const Duration(days: 7)))
                                      ? DesignColor.backgroundColor
                                      : DesignColor.backgroundColor1,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedDate = DateTime.now()
                                        .add(const Duration(days: 7));
                                  });
                                },
                                child: DesignText(
                                  'After 1 week',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: DesignUtils.isSameDateTime(
                                          _selectedDate,
                                          btnselectedDate
                                              .add(const Duration(days: 7)))
                                      ? Colors.white
                                      : null,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (isNoDate || widget.isNoDate)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: isNoDate && widget.isNoDate
                                    ? DesignColor.backgroundColor
                                    : DesignColor.backgroundColor1,
                              ),
                              onPressed: () {
                                setState(() {
                                  isNoDate = true;
                                  _selectedDate = btnselectedDate;
                                });
                              },
                              child: DesignText(
                                'No date',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isNoDate && widget.isNoDate
                                    ? Colors.white
                                    : null,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: isNoDate && widget.isNoDate
                                    ? DesignColor.backgroundColor1
                                    : DesignUtils.isSameDateTime(
                                            _selectedDate, btnselectedDate)
                                        ? DesignColor.backgroundColor
                                        : DesignColor.backgroundColor1,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedDate = DateTime.now();
                                  isNoDate = false;
                                });
                              },
                              child: DesignText(
                                'Today',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isNoDate && widget.isNoDate
                                    ? null
                                    : DesignUtils.isSameDateTime(
                                            _selectedDate, btnselectedDate)
                                        ? Colors.white
                                        : null,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 280,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: !isNoDate
                          ? null
                          : const ColorScheme.light(
                              primary: Colors.transparent,
                              onPrimary: Colors.blue,
                            ),
                    ),
                    child: CalendarDatePicker(
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      onDateChanged: (newDate) {
                        setState(() {
                          _selectedDate = newDate;
                          isNoDate = false;
                        });
                      },
                      onDisplayedMonthChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 0, thickness: 1, color: DesignColor.color6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 88,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.event_rounded,
                        color: DesignColor.todoBlue,
                      ),
                      const SizedBox(width: 6),
                      DesignText(
                        isNoDate
                            ? 'No date'
                            : DateFormat('d MMM y').format(_selectedDate),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                  Row(
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
                              Navigator.pop(context, {
                                'isNoDate': isNoDate,
                                'dateTime': _selectedDate,
                              });
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
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
