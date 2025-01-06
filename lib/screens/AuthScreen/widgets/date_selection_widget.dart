import 'package:flutter/material.dart';

class BirthdateSelectionWidget extends StatefulWidget {
  final Function(int, int, int) onDateSelected;
  const BirthdateSelectionWidget({super.key, required this.onDateSelected});

  @override
  // ignore: library_private_types_in_public_api
  _BirthdateSelectionWidgetState createState() =>
      _BirthdateSelectionWidgetState();
}

class _BirthdateSelectionWidgetState extends State<BirthdateSelectionWidget> {
  int _selectedDay = DateTime.now().day;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year - 18;

  final List<int> _days = List.generate(31, (index) => index + 1);
  final List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  final List<int> _years =
      List.generate(100, (index) => DateTime.now().year - 99 + index);

  void _updateDate() {
    widget.onDateSelected(_selectedDay, _selectedMonth, _selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListWheelScrollView.useDelegate(
                      controller: FixedExtentScrollController(
                          initialItem: _selectedDay - 1),
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedDay = _days[index % _days.length];
                          _updateDate(); // Send updated values
                        });
                      },
                      childDelegate: ListWheelChildLoopingListDelegate(
                        children: _days.map((day) {
                          return Center(
                            child: Text(
                              day.toString(),
                              style: TextStyle(
                                fontSize: _selectedDay == day ? 20 : 16,
                                fontWeight: _selectedDay == day
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: _selectedDay == day
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    _buildHorizontalDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Month Picker
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListWheelScrollView.useDelegate(
                      controller: FixedExtentScrollController(
                          initialItem: _selectedMonth - 1),
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedMonth = (index % _months.length) + 1;
                          _updateDate(); // Send updated values
                        });
                      },
                      childDelegate: ListWheelChildLoopingListDelegate(
                        children: _months.map((month) {
                          return Center(
                            child: Text(
                              month,
                              style: TextStyle(
                                fontSize: _selectedMonth ==
                                        (_months.indexOf(month) + 1)
                                    ? 20
                                    : 16,
                                fontWeight: _selectedMonth ==
                                        (_months.indexOf(month) + 1)
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: _selectedMonth ==
                                        (_months.indexOf(month) + 1)
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    _buildHorizontalDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Year Picker
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListWheelScrollView.useDelegate(
                      controller: FixedExtentScrollController(initialItem: 18),
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedYear = _years[index];
                          _updateDate(); // Send updated values
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: _years.length,
                        builder: (context, index) {
                          return Center(
                            child: Text(
                              _years[index].toString(),
                              style: TextStyle(
                                fontSize:
                                    _selectedYear == _years[index] ? 20 : 16,
                                fontWeight: _selectedYear == _years[index]
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: _selectedYear == _years[index]
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    _buildHorizontalDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalDivider() {
    return Positioned(
      top: 40,
      left: 30,
      right: 30,
      child: Column(
        children: [
          Container(
            height: 1.3,
            color: Colors.grey.shade500,
          ),
          const SizedBox(height: 40),
          Container(
            height: 1.3,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}
