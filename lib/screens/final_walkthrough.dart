import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/components/primary_button.dart';

class FinalWalkthroughScreen extends StatefulWidget {
  const FinalWalkthroughScreen({super.key});

  @override
  State<FinalWalkthroughScreen> createState() => _FinalWalkthroughScreenState();
}

class _FinalWalkthroughScreenState extends State<FinalWalkthroughScreen> {
  final DateTime _currentDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  int selectedTimeSlot = 0;

  int _daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(_currentDay.year, _currentDay.month, 1);
    var firstDayNextMonth =
        DateTime(_currentDay.year, _currentDay.month + 1, 1);

    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Today, ",
                      ),
                      TextSpan(
                        text: DateFormat('EEEE d MMMM').format(_currentDay),
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 21,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      int daysInCurrentMonth = _daysInMonth(_currentDay);

                      int day = _currentDay.day + index;

                      DateTime actualDate;

                      if (day > daysInCurrentMonth) {
                        int nextMonthDay = day - daysInCurrentMonth;
                        actualDate = DateTime(_currentDay.year,
                            _currentDay.month + 1, nextMonthDay);
                      } else {
                        actualDate =
                            DateTime(_currentDay.year, _currentDay.month, day);
                      }

                      if (actualDate.month > 12) {
                        actualDate =
                            DateTime(actualDate.year + 1, 1, actualDate.day);
                      }

                      String dayOfWeek = DateFormat('EEE').format(actualDate);
                      String dayOfMonth = actualDate.day.toString();

                      return Theme(
                        data: ThemeData(
                          splashColor: Colors.blue[400],
                        ),
                        child: SizedBox(
                          width: 100,
                          child: Material(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.blue,
                                width: 1.4,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: _selectedDay == actualDate
                                ? Colors.blue
                                : Colors.white,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedDay = actualDate;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dayOfWeek,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: _selectedDay == actualDate
                                          ? Colors.white
                                          : Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    dayOfMonth,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: _selectedDay == actualDate
                                          ? Colors.white
                                          : Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Time slots",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _timeSlots(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12),
                child: PrimaryButton(
                  label: "Select",
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeSlots() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        bool isSelected = selectedTimeSlot == index;

        int start = 8 + (index * 2);
        int end = 10 + (index * 2);

        return Material(
          shadowColor: Colors.black45,
          elevation: 1,
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              setState(() {
                selectedTimeSlot = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "$start:00 - $end:00",
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      },
    );
  }
}
