import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalendarHomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
    );
  }
}

class CalendarHomeScreen extends StatefulWidget {
  const CalendarHomeScreen({super.key});

  @override
  State<CalendarHomeScreen> createState() => _CalendarHomeScreenState();
}

class _CalendarHomeScreenState extends State<CalendarHomeScreen> {
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> events = [
    {"date": DateTime(2024, 4, 1), "title": "Nazmul's Birthday", "time": "6:30 PM"},
    {"date": DateTime(2024, 4, 12), "title": "Saidur's Anniversary", "time": "8:00 PM"},
    {"date": DateTime(2024, 4, 20), "title": "Zoom Meeting invitation", "time": "10:30 AM - 12:30 PM"},
    {"date": DateTime(2024, 5, 5), "title": "Cricket Match Team", "time": "2:30 PM - 5:30 PM"},
  ];

  List<DateTime> getCurrentMonthDays() {
    final now = selectedDate;
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);
    return List.generate(lastDay.day, (i) => DateTime(now.year, now.month, i + 1));
  }

  @override
  Widget build(BuildContext context) {
    final days = getCurrentMonthDays();
    final monthName = DateFormat('MMMM yyyy').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              monthName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.filter_list, color: Colors.black54),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final isSelected = day.day == selectedDate.day &&
                    day.month == selectedDate.month &&
                    day.year == selectedDate.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = day;
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepPurple : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E').format(day).substring(0, 3),
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _groupEventsByMonth(),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.email_outlined), label: 'Mail'),
          BottomNavigationBarItem(icon: Icon(Icons.task_alt_outlined), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.video_call_outlined), label: 'Meet'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud_outlined), label: 'Drive'),
        ],
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }

  List<Widget> _groupEventsByMonth() {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var event in events) {
      final month = DateFormat('MMMM yyyy').format(event['date']);
      grouped.putIfAbsent(month, () => []);
      grouped[month]!.add(event);
    }

    List<Widget> widgets = [];
    grouped.forEach((month, evs) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            month,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
      for (var e in evs) {
        widgets.add(
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('MMM').format(e['date']),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        DateFormat('dd').format(e['date']),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        e['time'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.event, color: Colors.black45),
              ],
            ),
          ),
        );
      }
    });

    return widgets;
  }
}