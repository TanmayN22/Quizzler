import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quizller/app/home/widgets/statbox.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/utils/helpers/responsive.dart';
import '../model/data_stats_model.dart';

class DailyStatContainer extends StatefulWidget {
  const DailyStatContainer({super.key});

  @override
  State<DailyStatContainer> createState() => _DailyStatContainerState();
}

class _DailyStatContainerState extends State<DailyStatContainer> {
  late DateTime _selectedDate;

  Map<DateTime, DailyStats> get _statsData => {
        _normalizeDate(DateTime.now()):
            DailyStats(tests: 3, lectures: 12, score: 72),
        _normalizeDate(DateTime.now().subtract(const Duration(days: 1))):
            DailyStats(tests: 5, lectures: 10, score: 85),
        _normalizeDate(DateTime.now().subtract(const Duration(days: 2))):
            DailyStats(tests: 2, lectures: 8, score: 60),
      };

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void _goToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _goToNextDay() {
    // Preventing it from navigating to the future
    if (_normalizeDate(_selectedDate)
        .isBefore(_normalizeDate(DateTime.now()))) {
      setState(() {
        _selectedDate = _selectedDate.add(const Duration(days: 1));
      });
    }
  }

  String _formatDateHeader(DateTime date) {
    final today = _normalizeDate(DateTime.now());
    final yesterday = today.subtract(const Duration(days: 1));
    final selectedDay = _normalizeDate(date);

    if (selectedDay == today) {
      return 'Today';
    } else if (selectedDay == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isToday =
        _normalizeDate(_selectedDate) == _normalizeDate(DateTime.now());
    final stats = _statsData[_normalizeDate(_selectedDate)] ??
        DailyStats(tests: 0, lectures: 0, score: 0);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: AppSizes.p12, right: AppSizes.p12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: _goToPreviousDay,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              Text(
                _formatDateHeader(_selectedDate),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Opacity(
                opacity: isToday ? 0.3 : 1.0,
                child: IconButton(
                  onPressed: isToday ? null : _goToNextDay,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: AppSizes.p12.w, right: AppSizes.p12.w),
          child: Container(
            width: Get.width,
            height: 120,
            decoration: BoxDecoration(
                color: colorScheme.secondary,
                border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  statBox(context, 'Tests', '${stats.tests}'),
                  statBox(context, 'Lectures', '${stats.lectures}'),
                  statBox(context, 'Score', '${stats.score}')
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
