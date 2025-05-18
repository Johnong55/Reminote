import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/widgets/Streak_Home/StreakDayItem.dart';
import 'package:intl/intl.dart';
import 'package:study_app/providers/Completion_provider.dart';

class StreakCalendar extends StatefulWidget {
  final List<bool> completedDays;
  final Color streakColor;
  final bool isDarkMode;
  final DateTime? chosenDate;
  final void Function(DateTime) onDateSelected;
  final bool isCompletedToday;
  const StreakCalendar({
    super.key,
    required this.completedDays,
    required this.streakColor,
    required this.isDarkMode,
    required this.chosenDate,
    required this.onDateSelected,
    required this.isCompletedToday,
  });

  @override
  State<StreakCalendar> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State<StreakCalendar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Delay scroll until after first frame render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Each item is ~64px wide (adjust if needed)
      double itemWidth = 64;
      int todayIndex = 4; // Center of 9-day list (index 4)
      _scrollController.jumpTo((itemWidth * todayIndex) - (MediaQuery.of(context).size.width / 2) + (itemWidth / 2));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final today = DateTime.now();
    final startDate = today.subtract(const Duration(days: 4)); // 4 days before today

    return GestureDetector(
      onTap:() {
       
      } ,
      child: Container( 
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!widget.isDarkMode)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Your streak history', style: textTheme.titleMedium),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 9,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final date = startDate.add(Duration(days: index));
                  final isCompleted = widget.completedDays.length > index
                      ? widget.completedDays[index]
                      : false;
                  final isChosen = widget.chosenDate != null &&
                      _isSameDay(date, widget.chosenDate!);
                  final isToday = _isSameDay(date, today);
      
                  return StreakDayItem(
                    date: date,
                    isToday: isToday,
                    isChosen: isChosen,
                    isCompleted: isToday? widget.isCompletedToday: isCompleted ,
                    streakColor: widget.streakColor,
                    isDarkMode: widget.isDarkMode,
                    ontap: () => widget.onDateSelected(date),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
